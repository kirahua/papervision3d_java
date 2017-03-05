﻿package org.papervision3d.core
{
	import org.papervision3d.core.Number3D;
	
	/**
	 * 三维转换矩阵
	 */
	public class Matrix3D
	{
		static private var toDEGREES:Number = 180 / Math.PI;
		static private var toRADIANS:Number = Math.PI / 180;
		
		public var n11:Number;		
		public var n12:Number;		
		public var n13:Number;		
		public var n14:Number;
		public var n21:Number;		
		public var n22:Number;		
		public var n23:Number;		
		public var n24:Number;
		public var n31:Number;		
		public var n32:Number;		
		public var n33:Number;		
		public var n34:Number;
		
		/**
		 * 构造函数
		 * @param	args
		 */
		public function Matrix3D(args:Array)
		{
			if( args.length >= 12 )
			{
				n11 = args[0]; 
				n12 = args[1];  
				n13 = args[2];  
				n14 = args[3];
				n21 = args[4];  
				n22 = args[5];  
				n23 = args[6];  
				n24 = args[7];
				n31 = args[8];  
				n32 = args[9];  
				n33 = args[10]; 
				n34 = args[11];
			}
			else
			{
				n11 = n22 = n33 = 1;
				n12 = n13 = n14 = n21 = n23 = n24 = n31 = n32 = n34 = 0;
			}
		}
		
		/**
		 * 单元
		 */
		public static function get IDENTITY():Matrix3D
		{
			return new Matrix3D
			(
				[
					1, 0, 0, 0,
					0, 1, 0, 0,
					0, 0, 1, 0
				]
			);
		}
		
		/**
		 * 字符串形式
		 * @return
		 */
		public function toString(): String
		{
			var s:String = "";
			s += int(n11*1000)/1000 + "\t\t" + int(n12*1000)/1000 + "\t\t" + int(n13*1000)/1000 + "\t\t" + int(n14*1000)/1000 +"\n";
			s += int(n21*1000)/1000 + "\t\t" + int(n22*1000)/1000 + "\t\t" + int(n23*1000)/1000 + "\t\t" + int(n24*1000)/1000 + "\n";
			s += int(n31*1000)/1000 + "\t\t" + int(n32*1000)/1000 + "\t\t" + int(n33*1000)/1000 + "\t\t" + int(n34*1000)/1000 + "\n";
			return s;
		}
		
		/**
		 * 乘
		 * @param	m1
		 * @param	m2
		 * @return
		 */
		public static function multiply3x3(m1:Matrix3D, m2:Matrix3D):Matrix3D
		{
			var dest:Matrix3D = IDENTITY;
			var m111:Number = m1.n11; 
			var m211:Number = m2.n11;
			var m121:Number = m1.n21; 
			var m221:Number = m2.n21;
			var m131:Number = m1.n31; 
			var m231:Number = m2.n31;
			var m112:Number = m1.n12; 
			var m212:Number = m2.n12;
			var m122:Number = m1.n22; 
			var m222:Number = m2.n22;
			var m132:Number = m1.n32; 
			var m232:Number = m2.n32;
			var m113:Number = m1.n13; 
			var m213:Number = m2.n13;
			var m123:Number = m1.n23; 
			var m223:Number = m2.n23;
			var m133:Number = m1.n33; 
			var m233:Number = m2.n33;
			dest.n11 = m111 * m211 + m112 * m221 + m113 * m231;
			dest.n12 = m111 * m212 + m112 * m222 + m113 * m232;
			dest.n13 = m111 * m213 + m112 * m223 + m113 * m233;
			dest.n21 = m121 * m211 + m122 * m221 + m123 * m231;
			dest.n22 = m121 * m212 + m122 * m222 + m123 * m232;
			dest.n23 = m121 * m213 + m122 * m223 + m123 * m233;
			dest.n31 = m131 * m211 + m132 * m221 + m133 * m231;
			dest.n32 = m131 * m212 + m132 * m222 + m133 * m232;
			dest.n33 = m131 * m213 + m132 * m223 + m133 * m233;
			dest.n14 = m1.n14;
			dest.n24 = m1.n24;
			dest.n34 = m1.n34;
			return dest;
		}
		
		/**
		 * 旋转
		 * @param	m
		 * @param	v
		 */
		public static function rotateAxis(m:Matrix3D, v:Number3D):void
		{
			var vx:Number, vy:Number, vz:Number;
			v.x = (vx = v.x) * m.n11 + (vy = v.y) * m.n12 + (vz = v.z) * m.n13;
			v.y = vx * m.n21 + vy * m.n22 + vz * m.n23;
			v.z = vx * m.n31 + vy * m.n32 + vz * m.n33;
			v.normalize();
		}
		
		/**
		 * 乘
		 * @param	m1
		 * @param	m2
		 * @return
		 */
		public static function multiply(m1:Matrix3D, m2:Matrix3D):Matrix3D
		{
			var dest:Matrix3D = IDENTITY;
			var m111:Number, m211:Number, m121:Number, m221:Number, m131:Number, m231:Number;
			var m112:Number, m212:Number, m122:Number, m222:Number, m132:Number, m232:Number;
			var m113:Number, m213:Number, m123:Number, m223:Number, m133:Number, m233:Number;
			var m114:Number, m214:Number, m124:Number, m224:Number, m134:Number, m234:Number;
			dest.n11 = (m111=m1.n11) * (m211=m2.n11) + (m112=m1.n12) * (m221=m2.n21) + (m113=m1.n13) * (m231=m2.n31);
			dest.n12 = m111 * (m212=m2.n12) + m112 * (m222=m2.n22) + m113 * (m232=m2.n32);
			dest.n13 = m111 * (m213=m2.n13) + m112 * (m223=m2.n23) + m113 * (m233=m2.n33);
			dest.n14 = m111 * (m214=m2.n14) + m112 * (m224=m2.n24) + m113 * (m234=m2.n34) + (m114=m1.n14);
			dest.n21 = (m121=m1.n21) * m211 + (m122=m1.n22) * m221 + (m123=m1.n23) * m231;
			dest.n22 = m121 * m212 + m122 * m222 + m123 * m232;
			dest.n23 = m121 * m213 + m122 * m223 + m123 * m233;
			dest.n24 = m121 * m214 + m122 * m224 + m123 * m234 + (m124=m1.n24);
			dest.n31 = (m131=m1.n31) * m211 + (m132=m1.n32) * m221 + (m133=m1.n33) * m231;
			dest.n32 = m131 * m212 + m132 * m222 + m133 * m232;
			dest.n33 = m131 * m213 + m132 * m223 + m133 * m233;
			dest.n34 = m131 * m214 + m132 * m224 + m133 * m234 + (m134=m1.n34);
			return dest;
		}
		
		/**
		 * 加
		 * @param	m1
		 * @param	m2
		 * @return
		 */
		public static function add(m1:Matrix3D, m2:Matrix3D):Matrix3D
		{
			var dest:Matrix3D = IDENTITY;
			dest.n11 = m1.n11 + m2.n11; 	
			dest.n12 = m1.n12 + m2.n12;
			dest.n13 = m1.n13 + m2.n13;	
			dest.n14 = m1.n14 + m2.n14;
			dest.n21 = m1.n21 + m2.n21;	
			dest.n22 = m1.n22 + m2.n22;
			dest.n23 = m1.n23 + m2.n23;	
			dest.n24 = m1.n24 + m2.n24;
			dest.n31 = m1.n31 + m2.n31;	
			dest.n32 = m1.n32 + m2.n32;
			dest.n33 = m1.n33 + m2.n33;	
			dest.n34 = m1.n34 + m2.n34;
			return dest;
		}
		
		/**
		 * 复制
		 * @param	m
		 * @return
		 */
		public function copy(m:Matrix3D):Matrix3D
		{
			this.n11 = m.n11;	
			this.n12 = m.n12;
			this.n13 = m.n13;	
			this.n14 = m.n14;
			this.n21 = m.n21;	
			this.n22 = m.n22;
			this.n23 = m.n23;	
			this.n24 = m.n24;
			this.n31 = m.n31;	
			this.n32 = m.n32;
			this.n33 = m.n33;	
			this.n34 = m.n34;
			return this;
		}
		
		/**
		 * 3x3复制
		 * @param	m
		 * @return
		 */
		public function copy3x3(m:Matrix3D):Matrix3D
		{
			this.n11 = m.n11;   
			this.n12 = m.n12;   
			this.n13 = m.n13;
			this.n21 = m.n21;  
			this.n22 = m.n22;   
			this.n23 = m.n23;
			this.n31 = m.n31;   
			this.n32 = m.n32;   
			this.n33 = m.n33;
			return this;
		}

		/**
		 * 复制
		 * @param	m
		 * @return
		 */
		public static function clone(m:Matrix3D):Matrix3D
		{
			return new Matrix3D
			(
				[
					m.n11, m.n12, m.n13, m.n14,
					m.n21, m.n22, m.n23, m.n24,
					m.n31, m.n32, m.n33, m.n34
				]
			);
		}

		/**
		 * 乘
		 * @param	m
		 * @param	v
		 */
		public static function multiplyVector(m:Matrix3D, v:Number3D):void
		{
			var vx:Number, vy:Number, vz:Number;
			v.x = (vx = v.x) * m.n11 + (vy = v.y) * m.n12 + (vz = v.z) * m.n13 + m.n14;
			v.y = vx * m.n21 + vy * m.n22 + vz * m.n23 + m.n24;
			v.z = vx * m.n31 + vy * m.n32 + vz * m.n33 + m.n34;
		}
		
		/**
		 * 3x3乘
		 * @param	m
		 * @param	v
		 */
		public static function multiplyVector3x3(m:Matrix3D, v:Number3D):void
		{
			var vx:Number, vy:Number, vz:Number;
			v.x = (vx = v.x) * m.n11 + (vy = v.y) * m.n12 + (vz = v.z) * m.n13;
			v.y = vx * m.n21 + vy * m.n22 + vz * m.n23;
			v.z = vx * m.n31 + vy * m.n32 + vz * m.n33;
		}
		
		/**
		 * 矩阵转为欧拉数？
		 * @param	mat
		 * @return
		 */
		public static function matrix2euler(mat:Matrix3D):Number3D
		{
			var angle:Number3D = new Number3D();
			var d:Number = -Math.asin(Math.max(-1, Math.min(1, mat.n13)));
			var c:Number = Math.cos(d);
			angle.y = d * toDEGREES;
			var trX:Number, trY:Number;
			if (Math.abs(c) > 0.005)
			{
				trX = mat.n33 / c;
				trY = -mat.n23 / c;
				angle.x = Math.atan2( trY, trX ) * toDEGREES;
				trX = mat.n11 / c;
				trY = -mat.n12 / c;
				angle.z = Math.atan2( trY, trX ) * toDEGREES;
			}
			else
			{
				angle.x = 0;
				trX = mat.n22;
				trY = mat.n21;
				angle.z = Math.atan2( trY, trX ) * toDEGREES;
			}
			return angle;
		}
		
		/**
		 * 欧拉数转矩阵
		 * @param	angle
		 * @return
		 */
		public static function euler2matrix(angle:Number3D):Matrix3D
		{
			var m:Matrix3D = IDENTITY;
			var ax:Number = angle.x * toRADIANS;
			var ay:Number = angle.y * toRADIANS;
			var az:Number = angle.z * toRADIANS;
			var a:Number = Math.cos(ax);
			var b:Number = Math.sin(ax);
			var c:Number = Math.cos(ay);
			var d:Number = Math.sin(ay);
			var e:Number = Math.cos(az);
			var f:Number = Math.sin(az);
			var ad:Number = a * d;
			var bd:Number = b * d;
			m.n11 = c * e;
			m.n12 = -c * f;
			m.n13 = d;
			m.n21 = bd * e + a * f;
			m.n22 = -bd * f + a * e;
			m.n23 = -b * c;
			m.n31 = -ad * e + b * f;
			m.n32 = ad * f + b * e;
			m.n33 = a * c;
			return m;
		}
		
		/**
		 * 绕X轴旋转
		 * @param	angleRad
		 * @return
		 */
		public static function rotationX(angleRad:Number):Matrix3D
		{
			var m:Matrix3D = IDENTITY;
			var c:Number = Math.cos(angleRad);
			var s:Number = Math.sin(angleRad);
			m.n22 = c;
			m.n23 = -s;
			m.n32 = s;
			m.n33 = c;
			return m;
		}
		
		/**
		 * 绕Y轴旋转
		 * @param	angleRad
		 * @return
		 */
		public static function rotationY(angleRad:Number):Matrix3D
		{
			var m:Matrix3D = IDENTITY;
			var c:Number = Math.cos(angleRad);
			var s:Number = Math.sin(angleRad);
			m.n11 = c;
			m.n13 = -s;
			m.n31 = s;
			m.n33 = c;
			return m;
		}
		
		/**
		 * 绕Z轴旋转
		 * @param	angleRad
		 * @return
		 */
		public static function rotationZ(angleRad:Number):Matrix3D
		{
			var m:Matrix3D = IDENTITY;
			var c:Number = Math.cos(angleRad);
			var s:Number = Math.sin(angleRad);
			m.n11 = c;
			m.n12 = -s;
			m.n21 = s;
			m.n22 = c;
			return m;
		}
		
		/**
		 * 绕矩阵旋转
		 * @param	u
		 * @param	v
		 * @param	w
		 * @param	angle
		 * @return
		 */
		public static function rotationMatrix(u:Number, v:Number, w:Number, angle:Number):Matrix3D
		{
			var m:Matrix3D = IDENTITY;
			var nCos:Number	= Math.cos(angle);
			var nSin:Number	= Math.sin(angle);
			var scos:Number	= 1 - nCos;
			var suv:Number = u * v * scos;
			var svw:Number = v * w * scos;
			var suw:Number = u * w * scos;
			var sw:Number = nSin * w;
			var sv:Number = nSin * v;
			var su:Number = nSin * u;
			m.n11 = nCos + u * u * scos;
			m.n12 = -sw + suv;
			m.n13 = sv + suw;
			m.n21 = sw + suv;
			m.n22 = nCos + v * v * scos;
			m.n23 = -su + svw;
			m.n31 = -sv + suw;
			m.n32 = su + svw;
			m.n33 = nCos + w * w * scos;
			return m;
		}
		
		/**
		 * 平移
		 * @param	u
		 * @param	v
		 * @param	w
		 * @return
		 */
		public static function translationMatrix(u:Number, v:Number, w:Number):Matrix3D
		{
			var m:Matrix3D = IDENTITY;
			m.n14 = u;
			m.n24 = v;
			m.n34 = w;
			return m;
		}
		
		/**
		 * 缩放
		 * @param	u
		 * @param	v
		 * @param	w
		 * @return
		 */
		public static function scaleMatrix(u:Number, v:Number, w:Number):Matrix3D
		{
			var m:Matrix3D = IDENTITY;
			m.n11 = u;
			m.n22 = v;
			m.n33 = w;
			return m;
		}
		
		/**
		 * 矩阵秩
		 */
		public function get det():Number
		{
			return (this.n11 * this.n22 - this.n21 * this.n12) * this.n33 - (this.n11 * this.n32 - this.n31 * this.n12) * this.n23 +
				(this.n21 * this.n32 - this.n31 * this.n22) * this.n13;
		}
		
		/**
		 * ?
		 * @param	m
		 * @return
		 */
		public static function getTrace(m:Matrix3D):Number
		{
			return m.n11 + m.n22 + m.n33 + 1;
		}
		
		/**
		 * 逆矩阵
		 * @param	m
		 * @return
		 */
		public static function inverse( m:Matrix3D ):Matrix3D
		{
			var d:Number = m.det;
			if (Math.abs(d) < 0.001)
			{
				return null;
			}
			d = 1/d;
			var m11:Number = m.n11; var m21:Number = m.n21; var m31:Number = m.n31;
			var m12:Number = m.n12; var m22:Number = m.n22; var m32:Number = m.n32;
			var m13:Number = m.n13; var m23:Number = m.n23; var m33:Number = m.n33;
			var m14:Number = m.n14; var m24:Number = m.n24; var m34:Number = m.n34;
			return new Matrix3D
			(
				[
					d * ( m22 * m33 - m32 * m23 ),
					-d* ( m12 * m33 - m32 * m13 ),
					d * ( m12 * m23 - m22 * m13 ),
					-d* ( m12 * (m23*m34 - m33*m24) - m22 * (m13*m34 - m33*m14) + m32 * (m13*m24 - m23*m14) ),
					-d* ( m21 * m33 - m31 * m23 ),
					d * ( m11 * m33 - m31 * m13 ),
					-d* ( m11 * m23 - m21 * m13 ),
					d * ( m11 * (m23*m34 - m33*m24) - m21 * (m13*m34 - m33*m14) + m31 * (m13*m24 - m23*m14) ),
					d * ( m21 * m32 - m31 * m22 ),
					-d* ( m11 * m32 - m31 * m12 ),
					d * ( m11 * m22 - m21 * m12 ),
					-d* ( m11 * (m22*m34 - m32*m24) - m21 * (m12*m34 - m32*m14) + m31 * (m12*m24 - m22*m14) )
				]
			);
		}
		
		/**
		 * 轴旋转
		 * @param	axis
		 * @param	ref
		 * @param	pAngle
		 * @return
		 */
		public static function axisRotationWithReference(axis:Number3D, ref:Number3D, pAngle:Number):Matrix3D
		{
			var angle:Number = (pAngle + 360) % 360;
			var m:Matrix3D = Matrix3D.translationMatrix(ref.x, -ref.y, ref.z);
			m = Matrix3D.multiply(m, Matrix3D.rotationMatrix(axis.x, axis.y, axis.z, angle));
			m = Matrix3D.multiply(m, Matrix3D.translationMatrix(-ref.x, ref.y, -ref.z));
			return m;
		}
		
		/**
		 * 四元数转矩阵
		 * @param	x
		 * @param	y
		 * @param	z
		 * @param	w
		 * @return
		 */
		public static function quaternion2matrix(x:Number, y:Number, z:Number, w:Number):Matrix3D
		{
			var xx:Number = x * x;
			var xy:Number = x * y;
			var xz:Number = x * z;
			var xw:Number = x * w;
			var yy:Number = y * y;
			var yz:Number = y * z;
			var yw:Number = y * w;
			var zz:Number = z * z;
			var zw:Number = z * w;
			var m:Matrix3D = IDENTITY;
			m.n11 = 1 - 2 * (yy + zz);
			m.n12 = 2 * (xy - zw);
			m.n13 = 2 * (xz + yw);
			m.n21 = 2 * (xy + zw);
			m.n22 = 1 - 2 * (xx + zz);
			m.n23 = 2 * (yz - xw);
			m.n31 = 2 * (xz - yw);
			m.n32 = 2 * (yz + xw);
			m.n33 = 1 - 2 * (xx + yy);
			return m;
		}
		
		/**
		 * 欧拉数转四元数
		 * @param	ax
		 * @param	ay
		 * @param	az
		 * @return
		 */
		public static function euler2quaternion(ax:Number, ay:Number, az:Number):Object
		{
			var fSinPitch:Number = Math.sin(ax * 0.5);
			var fCosPitch:Number = Math.cos(ax * 0.5);
			var fSinYaw:Number = Math.sin(ay * 0.5);
			var fCosYaw:Number = Math.cos(ay * 0.5);
			var fSinRoll:Number = Math.sin(az * 0.5);
			var fCosRoll:Number = Math.cos(az * 0.5);
			var fCosPitchCosYaw:Number = fCosPitch * fCosYaw;
			var fSinPitchSinYaw:Number = fSinPitch * fSinYaw;
			var q:Object = new Object();
			q.x = fSinRoll * fCosPitchCosYaw - fCosRoll * fSinPitchSinYaw;
			q.y = fCosRoll * fSinPitch * fCosYaw + fSinRoll * fCosPitch * fSinYaw;
			q.z = fCosRoll * fCosPitch * fSinYaw - fSinRoll * fSinPitch * fCosYaw;
			q.w = fCosRoll * fCosPitchCosYaw + fSinRoll * fSinPitchSinYaw;
			return q;
		}
		
		/**
		 * 乘四元数
		 * FIXME:qb
		 * @param	qa
		 * @param	qb
		 * @return
		 */
		public static function multiplyQuaternion(qa:Object, qb:Object):Object
		{
			var w1:Number = qa.w;
			var x1:Number = qa.x;  
			var y1:Number = qa.y;  
			var z1:Number = qa.z;
			var w2:Number = qa.w;  
			var x2:Number = qa.x;  
			var y2:Number = qa.y;  
			var z2:Number = qa.z;
			var q:Object = new Object();
			q.w = w1*w2 - x1*x2 - y1*y2 - z1*z2;
			q.x = w1*x2 + x1*w2 + y1*z2 - z1*y2;
			q.y = w1*y2 + y1*w2 + z1*x2 - x1*z2;
			q.z = w1*z2 + z1*w2 + x1*y2 - y1*x2;
			return q;
		}
		
		/**
		 * 轴转四元数
		 * @param	x
		 * @param	y
		 * @param	z
		 * @param	angle
		 * @return
		 */
		public static function axis2quaternion(x:Number, y:Number, z:Number, angle:Number):Object
		{
			var sin_a:Number = Math.sin(angle / 2);
			var cos_a:Number = Math.cos(angle / 2);
			var q:Object = new Object();
			q.x = x * sin_a;
			q.y = y * sin_a;
			q.z = z * sin_a;
			q.w = cos_a;
			return normalizeQuaternion(q);
		}
		
		/**
		 * 四元数大小
		 * @param	q
		 * @return
		 */
		public static function magnitudeQuaternion(q:Object):Number
		{
			return Math.sqrt(q.w * q.w + q.x * q.x + q.y * q.y + q.z * q.z);
		}
		
		/**
		 * 单位化四元数
		 * @param	q
		 * @return
		 */
		public static function normalizeQuaternion(q:Object):Object
		{
			var mag:Number = magnitudeQuaternion(q);
			q.x /= mag;
			q.y /= mag;
			q.z /= mag;
			q.w /= mag;
			return q;
		}
	}
}
