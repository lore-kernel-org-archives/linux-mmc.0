From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] sdhci-s3c: add regulator support
Date: Wed, 28 Jul 2010 08:41:49 -0700
Message-ID: <3482ADFC-0FFB-47AE-B809-C88AC8B92C7F@opensource.wolfsonmicro.com>
References: <1280326797-15792-1-git-send-email-m.szyprowski@samsung.com>
	<1280326797-15792-5-git-send-email-m.szyprowski@samsung.com>
	<4C504326.30708@gmail.com> (sfid-20100728_154813_432417_3ADF200E)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: multipart/mixed; boundary="===============0457660768=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4C504326.30708@gmail.com> (sfid-20100728_154813_432417_3ADF200E)
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maurus Cuelenaere <mcuelenaere@gmail.com>
Cc: "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "ben-linux@fluff.org" <ben-linux@fluff.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-mmc@vger.kernel.org


--===============0457660768==
Content-Type: multipart/alternative;
	boundary=Apple-Mail-1--770684855
Content-Transfer-Encoding: 7bit


--Apple-Mail-1--770684855
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On 28 Jul 2010, at 07:48, Maurus Cuelenaere <mcuelenaere@gmail.com> =
wrote:
>>=20
>> +	struct sdhci_s3c *sc =3D sdhci_priv(host);
>> +
>> +	if (sc->vmmc) {
>> +		int ret =3D regulator_disable(sc->vmmc);
>> +		if (ret)
>> +			return ret;
>> +		mdelay(2);
>=20
> Shouldn't these delays be handled in the regulator framework itself?

A 2ms delay on power down seems suspicious for a regulator. I'm not sure =
why this is required but if it is I suspect it's due to a large cap on =
the regulator output and light load rather than something that's always =
true for whatever regulator is providing the supply.=

--Apple-Mail-1--770684855
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body bgcolor=3D"#FFFFFF"><div><span class=3D"Apple-style-span" =
style=3D"-webkit-tap-highlight-color: rgba(26, 26, 26, 0.296875); =
-webkit-composition-fill-color: rgba(175, 192, 227, 0.230469); =
-webkit-composition-frame-color: rgba(77, 128, 180, 0.230469); ">On 28 =
Jul 2010, at 07:48, Maurus Cuelenaere &lt;<a =
href=3D"mailto:mcuelenaere@gmail.com">mcuelenaere@gmail.com</a>&gt; =
wrote:</span><br></div><blockquote type=3D"cite"><div><blockquote =
type=3D"cite"><font class=3D"Apple-style-span" =
color=3D"#000000"><br></font></blockquote><blockquote =
type=3D"cite"><span>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>struct sdhci_s3c *sc =3D =
sdhci_priv(host);</span><br></blockquote><blockquote =
type=3D"cite"><span>+</span><br></blockquote><blockquote =
type=3D"cite"><span>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if (sc-&gt;vmmc) =
{</span><br></blockquote><blockquote type=3D"cite"><span>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>int ret =3D=
 regulator_disable(sc-&gt;vmmc);</span><br></blockquote><blockquote =
type=3D"cite"><span>+<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span><span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span>if =
(ret)</span><br></blockquote><blockquote type=3D"cite"><span>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span>return =
ret;</span><br></blockquote><blockquote type=3D"cite"><span>+<span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	</span><span =
class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>mdelay(2);</span><br></blockquote><span></span><br><span>Shouldn't =
these delays be handled in the regulator framework itself?</span><font =
class=3D"Apple-style-span" color=3D"#000000"><font =
class=3D"Apple-style-span" =
color=3D"#0023A3"><br></font></font></div></blockquote><br><div>A 2ms =
delay on power down seems suspicious for a regulator. I'm not sure why =
this is required but if it is I suspect it's due to a large cap on the =
regulator output and light load rather than something that's always true =
for whatever regulator is providing the supply.</div></body></html>=

--Apple-Mail-1--770684855--


--===============0457660768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0457660768==--
