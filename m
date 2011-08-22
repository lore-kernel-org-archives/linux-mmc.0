From: Harishkumar V <harishpresent-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 6/6] arm: davinci: DA850: Add wl1271/wlan support
Date: Mon, 22 Aug 2011 13:07:39 +0530
Message-ID: <CANDx4kUXRaCAnYxBOY32tZjcWsrAJG4oYi1YiTxAz5f94Gwe6g@mail.gmail.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
	<1310303679-17936-7-git-send-email-ido@wizery.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024DD2CEC2@dbde02.ent.ti.com>
	<20110728183454.GE1985@WorkStation>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1476066449=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20110728183454.GE1985@WorkStation>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

--===============1476066449==
Content-Type: multipart/alternative; boundary=0015174029d05a2bdd04ab132751

--0015174029d05a2bdd04ab132751
Content-Type: text/plain; charset=ISO-8859-1

Hi,

to which davinci git repository this is uploaded, i am using
http://gitorious.org/linux-davinci, I cannot find it board-da850-evm.c.

>From where to pull this repository.

On Fri, Jul 29, 2011 at 12:04 AM, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org> wrote:

> Hi Sekhar,
>
> On Mon, Jul 25, 2011 at 11:10:55PM +0530, Nori, Sekhar wrote:
> > Adding a new kernel parameter requires update to
> > Documentation/kernel-parameters.txt as well.
> >
> > I am Ccing a couple of folks in case they have ideas on
> > whether there is a better way to pass this information
> > to the kernel. I assume there is no way to detect
> > this from hardware.
>
> Unfortunately, auto-detection of the reference clock is not currently
> possible. However, it might be a better idea to have the ability to
> override this value with a wl12xx module parameter instead of a kernel
> parameter. I'll drop this kernel parameter.
>
> > > +static struct davinci_mmc_config da850_mmc_wl12xx_config = {
> > > +   .get_ro         = NULL,
> > > +   .get_cd         = NULL,
> >
> > You can get rid of these NULL initializers.
>
> Sure.
>
> > > +   .set_power      = wl12xx_set_power,
> > > +   .wires          = 4,
> > > +   .max_freq       = 25000000,
> > > +   .caps           = MMC_CAP_4_BIT_DATA | MMC_CAP_NONREMOVABLE |
> > > +                     MMC_CAP_POWER_OFF_CARD,
> > > +   .version        = MMC_CTLR_VERSION_2,
> > > +};
>
> [...]
>
> > > +   ret = gpio_request_one(DA850_WLAN_EN, GPIOF_OUT_INIT_LOW,
> "wl12xx_en");
> > > +   if (ret) {
> > > +           pr_err("Error initializing the wl12xx enable gpio: %d\n",
> ret);
> > > +           return;
> > > +   }
> > > +
> > > +   ret = gpio_request_one(DA850_WLAN_IRQ, GPIOF_IN, "wl12xx_irq");
> > > +   if (ret) {
> > > +           pr_err("Error initializing the wl12xx irq gpio: %d\n",
> ret);
> > > +           gpio_free(DA850_WLAN_EN);
> > > +           return;
> > > +   }
> > > +
> > > +   da850_wl12xx_wlan_data.irq = gpio_to_irq(DA850_WLAN_IRQ);
> > > +   da850_wl12xx_wlan_data.board_ref_clock = da850_wl12xx_fref;
> > > +
> > > +   ret = wl12xx_set_platform_data(&da850_wl12xx_wlan_data);
> > > +   if (ret) {
> > > +           pr_err("Error setting wl12xx data: %d\n", ret);
> > > +           gpio_free(DA850_WLAN_IRQ);
> > > +           gpio_free(DA850_WLAN_EN);
> >
> > Why not just use the traditional goto based bail out
> > mechanism? You will avoid the multiple gpio_free() calls.
>
> Sure.
>
> Thanks for your review,
> Ido.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Thanks and Regards,
Harish Kumar. V

--0015174029d05a2bdd04ab132751
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>to which davinci git repository this is uploaded, i am using <a =
href=3D"http://gitorious.org/linux-davinci">http://gitorious.org/linux-davi=
nci</a>, I cannot find it board-da850-evm.c.<br><br>From where to pull this=
 repository.<br>
<br><div class=3D"gmail_quote">On Fri, Jul 29, 2011 at 12:04 AM, Ido Yariv =
<span dir=3D"ltr">&lt;<a href=3D"mailto:ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org">ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
Hi Sekhar,<br>
<div class=3D"im"><br>
On Mon, Jul 25, 2011 at 11:10:55PM +0530, Nori, Sekhar wrote:<br>
&gt; Adding a new kernel parameter requires update to<br>
&gt; Documentation/kernel-parameters.txt as well.<br>
&gt;<br>
&gt; I am Ccing a couple of folks in case they have ideas on<br>
&gt; whether there is a better way to pass this information<br>
&gt; to the kernel. I assume there is no way to detect<br>
&gt; this from hardware.<br>
<br>
</div>Unfortunately, auto-detection of the reference clock is not currently=
<br>
possible. However, it might be a better idea to have the ability to<br>
override this value with a wl12xx module parameter instead of a kernel<br>
parameter. I&#39;ll drop this kernel parameter.<br>
<div class=3D"im"><br>
&gt; &gt; +static struct davinci_mmc_config da850_mmc_wl12xx_config =3D {<b=
r>
&gt; &gt; + =A0 .get_ro =A0 =A0 =A0 =A0 =3D NULL,<br>
&gt; &gt; + =A0 .get_cd =A0 =A0 =A0 =A0 =3D NULL,<br>
&gt;<br>
&gt; You can get rid of these NULL initializers.<br>
<br>
</div>Sure.<br>
<div class=3D"im"><br>
&gt; &gt; + =A0 .set_power =A0 =A0 =A0=3D wl12xx_set_power,<br>
&gt; &gt; + =A0 .wires =A0 =A0 =A0 =A0 =A0=3D 4,<br>
&gt; &gt; + =A0 .max_freq =A0 =A0 =A0 =3D 25000000,<br>
&gt; &gt; + =A0 .caps =A0 =A0 =A0 =A0 =A0 =3D MMC_CAP_4_BIT_DATA | MMC_CAP_=
NONREMOVABLE |<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_CAP_POWER_OFF_CARD,=
<br>
&gt; &gt; + =A0 .version =A0 =A0 =A0 =A0=3D MMC_CTLR_VERSION_2,<br>
&gt; &gt; +};<br>
<br>
</div>[...]<br>
<div class=3D"im"><br>
&gt; &gt; + =A0 ret =3D gpio_request_one(DA850_WLAN_EN, GPIOF_OUT_INIT_LOW,=
 &quot;wl12xx_en&quot;);<br>
&gt; &gt; + =A0 if (ret) {<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 pr_err(&quot;Error initializing the wl12xx =
enable gpio: %d\n&quot;, ret);<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 return;<br>
&gt; &gt; + =A0 }<br>
&gt; &gt; +<br>
&gt; &gt; + =A0 ret =3D gpio_request_one(DA850_WLAN_IRQ, GPIOF_IN, &quot;wl=
12xx_irq&quot;);<br>
&gt; &gt; + =A0 if (ret) {<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 pr_err(&quot;Error initializing the wl12xx =
irq gpio: %d\n&quot;, ret);<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 gpio_free(DA850_WLAN_EN);<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 return;<br>
&gt; &gt; + =A0 }<br>
&gt; &gt; +<br>
&gt; &gt; + =A0 da850_wl12xx_wlan_data.irq =3D gpio_to_irq(DA850_WLAN_IRQ);=
<br>
&gt; &gt; + =A0 da850_wl12xx_wlan_data.board_ref_clock =3D da850_wl12xx_fre=
f;<br>
&gt; &gt; +<br>
&gt; &gt; + =A0 ret =3D wl12xx_set_platform_data(&amp;da850_wl12xx_wlan_dat=
a);<br>
&gt; &gt; + =A0 if (ret) {<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 pr_err(&quot;Error setting wl12xx data: %d\=
n&quot;, ret);<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 gpio_free(DA850_WLAN_IRQ);<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 gpio_free(DA850_WLAN_EN);<br>
&gt;<br>
&gt; Why not just use the traditional goto based bail out<br>
&gt; mechanism? You will avoid the multiple gpio_free() calls.<br>
<br>
</div>Sure.<br>
<br>
Thanks for your review,<br>
<font color=3D"#888888">Ido.<br>
</font><div><div></div><div class=3D"h5"><br>
_______________________________________________<br>
linux-arm-kernel mailing list<br>
<a href=3D"mailto:linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org">linux-arm-kernel@li=
sts.infradead.org</a><br>
<a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-kernel" ta=
rget=3D"_blank">http://lists.infradead.org/mailman/listinfo/linux-arm-kerne=
l</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Thanks and =
Regards,<br>Harish Kumar. V<br>

--0015174029d05a2bdd04ab132751--

--===============1476066449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1476066449==--
