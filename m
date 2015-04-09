From: Suman Tripathi <stripathi@apm.com>
Subject: Re: [PATCH v2 2/2] mmc: host: Add some quirks to be read from fdt in
 sdhci-pltm.c
Date: Thu, 9 Apr 2015 21:40:02 +0530
Message-ID: <CAOHikRArf+Fqv0JbQ1jM19zWGj-fBDcPie6apgkydgBLOm=x0w@mail.gmail.com>
References: <1427726768-17233-1-git-send-email-stripathi@apm.com>
 <1427726768-17233-3-git-send-email-stripathi@apm.com>
 <CAPDyKFoc0V5BdKCO8v92Y1qHzEPgwxRdYR3cCj8nCyU-s25NuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8323353036308433107=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <CAPDyKFoc0V5BdKCO8v92Y1qHzEPgwxRdYR3cCj8nCyU-s25NuQ@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Langsdorf <mlangsdo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jon Masters <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

--===============8323353036308433107==
Content-Type: multipart/alternative; boundary=e89a8f23558151639105134ce1fb

--e89a8f23558151639105134ce1fb
Content-Type: text/plain; charset=UTF-8

On 30 March 2015 at 16:46, Suman Tripathi <stripathi@apm.com> wrote:
> This patch adds some quirks support to be read from fdt.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c
b/drivers/mmc/host/sdhci-pltfm.c
> index bef250e..9f6a4b9 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device
*pdev)
>
>                 if (of_get_property(np, "broken-cd", NULL))
>                         host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +
> +               if (of_get_property(np, "delay-after-power", NULL))
> +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
> +
> +               if (of_get_property(np, "no-hispd", NULL))
> +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> +
> +               if (of_get_property(np, "broken-adma", NULL))
> +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +
> +               if (of_get_property(np, "broken-dma", NULL))
> +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> +
> +               if (of_get_property(np, "no-cmd23", NULL))
> +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;

Can't at least some of these be distinguished from what sdhci variant
that is being used? Instead of having them in DT...

We are using arasan controller in our SOC. So reusing a the existing
sdhci-of-arasan driver. Due to H/W issues we require this quirks. So for us
only option left to pass the info is DTS or ACPI table.

Kind regards
Uffe

On Wed, Apr 8, 2015 at 3:10 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On 30 March 2015 at 16:46, Suman Tripathi <stripathi@apm.com> wrote:
> > This patch adds some quirks support to be read from fdt.
> >
> > Signed-off-by: Suman Tripathi <stripathi@apm.com>
> > ---
> >  drivers/mmc/host/sdhci-pltfm.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pltfm.c
> b/drivers/mmc/host/sdhci-pltfm.c
> > index bef250e..9f6a4b9 100644
> > --- a/drivers/mmc/host/sdhci-pltfm.c
> > +++ b/drivers/mmc/host/sdhci-pltfm.c
> > @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device
> *pdev)
> >
> >                 if (of_get_property(np, "broken-cd", NULL))
> >                         host->quirks |=
> SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> > +
> > +               if (of_get_property(np, "delay-after-power", NULL))
> > +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
> > +
> > +               if (of_get_property(np, "no-hispd", NULL))
> > +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> > +
> > +               if (of_get_property(np, "broken-adma", NULL))
> > +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> > +
> > +               if (of_get_property(np, "broken-dma", NULL))
> > +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> > +
> > +               if (of_get_property(np, "no-cmd23", NULL))
> > +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>
> Can't at least some of these be distinguished from what sdhci variant
> that is being used? Instead of having them in DT...
>
> Kind regards
> Uffe
>
> >
> >                 if (of_get_property(np, "no-1-8-v", NULL))
> >                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
> > --
> > 1.8.2.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Thanks,
with regards,
Suman Tripathi

--e89a8f23558151639105134ce1fb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div id=3D":38l" tabindex=3D"-1" class=3D"" style=3D"font-=
size:medium"><div id=3D":383" class=3D"" tabindex=3D"0"><img class=3D"" src=
=3D"https://ssl.gstatic.com/ui/v1/icons/mail/images/cleardot.gif"></div></d=
iv><div id=3D":38x" class=3D"" style=3D"font-size:12.8000001907349px"><div =
id=3D":38y" class=3D"" style=3D"overflow:hidden"><div class=3D""><div class=
=3D"adm"></div><div class=3D"im">On 30 March 2015 at 16:46, Suman Tripathi =
&lt;<a href=3D"mailto:stripathi@apm.com">stripathi@apm.com</a>&gt; wrote:<b=
r>&gt; This patch adds some quirks support to be read from fdt.<br>&gt;<br>=
&gt; Signed-off-by: Suman Tripathi &lt;<a href=3D"mailto:stripathi@apm.com"=
>stripathi@apm.com</a>&gt;<br>&gt; ---<br>&gt;=C2=A0 drivers/mmc/host/sdhci=
-pltfm.c | 15 +++++++++++++++<br>&gt;=C2=A0 1 file changed, 15 insertions(+=
)<br>&gt;<br>&gt; diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc=
/host/sdhci-pltfm.c<br>&gt; index bef250e..9f6a4b9 100644<br>&gt; --- a/dri=
vers/mmc/host/sdhci-pltfm.c<br>&gt; +++ b/drivers/mmc/host/sdhci-pltfm.c<br=
>&gt; @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device =
*pdev)<br>&gt;<br>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (of_get_property(np, &quot;broken-cd&quot;, NULL))<br>&gt;=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0host-&gt;quirks |=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;<br>&gt=
; +<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (of_=
get_property(np, &quot;delay-after-power&quot;, NULL))<br>&gt; +=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ho=
st-&gt;quirks |=3D SDHCI_QUIRK_DELAY_AFTER_POWER;<br>&gt; +<br>&gt; +=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (of_get_property(np, &q=
uot;no-hispd&quot;, NULL))<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;quirks |=3D SDHCI_QUI=
RK_NO_HISPD_BIT;<br>&gt; +<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (of_get_property(np, &quot;broken-adma&quot;, NULL))<br=
>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0host-&gt;quirks |=3D SDHCI_QUIRK_BROKEN_ADMA;<br>&gt; +<br=
>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (of_get_pr=
operty(np, &quot;broken-dma&quot;, NULL))<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;quirks =
|=3D SDHCI_QUIRK_BROKEN_DMA;<br>&gt; +<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (of_get_property(np, &quot;no-cmd23&quot;, N=
ULL))<br>&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0host-&gt;quirks2 |=3D SDHCI_QUIRK2_HOST_NO_CMD23;<b=
r><br></div></div>Can&#39;t at least some of these be distinguished from wh=
at sdhci variant<br>that is being used? Instead of having them in DT...</di=
v><div id=3D":38y" class=3D"" style=3D"overflow:hidden"><br></div><div id=
=3D":38y" class=3D"" style=3D"overflow:hidden">We are using arasan controll=
er in our SOC. So reusing a the existing sdhci-of-arasan driver. Due to H/W=
 issues we require this quirks. So for us only option left to pass the info=
 is DTS or ACPI table.=C2=A0<br><br>Kind regards<br>Uffe<div class=3D""><di=
v id=3D":382" class=3D"" tabindex=3D"0"><img class=3D"" src=3D"https://ssl.=
gstatic.com/ui/v1/icons/mail/images/cleardot.gif"></div></div></div></div><=
/div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Apr =
8, 2015 at 3:10 PM, Ulf Hansson <span dir=3D"ltr">&lt;<a href=3D"mailto:ulf=
.hansson@linaro.org" target=3D"_blank">ulf.hansson@linaro.org</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=
=3D"h5">On 30 March 2015 at 16:46, Suman Tripathi &lt;<a href=3D"mailto:str=
ipathi@apm.com">stripathi@apm.com</a>&gt; wrote:<br>
&gt; This patch adds some quirks support to be read from fdt.<br>
&gt;<br>
&gt; Signed-off-by: Suman Tripathi &lt;<a href=3D"mailto:stripathi@apm.com"=
>stripathi@apm.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/mmc/host/sdhci-pltfm.c | 15 +++++++++++++++<br>
&gt;=C2=A0 1 file changed, 15 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-p=
ltfm.c<br>
&gt; index bef250e..9f6a4b9 100644<br>
&gt; --- a/drivers/mmc/host/sdhci-pltfm.c<br>
&gt; +++ b/drivers/mmc/host/sdhci-pltfm.c<br>
&gt; @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device *=
pdev)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (of_ge=
t_property(np, &quot;broken-cd&quot;, NULL))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0host-&gt;quirks |=3D SDHCI_QUIRK_BROKEN_CARD_DETECTION;=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (of_get_pro=
perty(np, &quot;delay-after-power&quot;, NULL))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0host-&gt;quirks |=3D SDHCI_QUIRK_DELAY_AFTER_POWER;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (of_get_pro=
perty(np, &quot;no-hispd&quot;, NULL))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0host-&gt;quirks |=3D SDHCI_QUIRK_NO_HISPD_BIT;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (of_get_pro=
perty(np, &quot;broken-adma&quot;, NULL))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0host-&gt;quirks |=3D SDHCI_QUIRK_BROKEN_ADMA;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (of_get_pro=
perty(np, &quot;broken-dma&quot;, NULL))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0host-&gt;quirks |=3D SDHCI_QUIRK_BROKEN_DMA;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (of_get_pro=
perty(np, &quot;no-cmd23&quot;, NULL))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0host-&gt;quirks2 |=3D SDHCI_QUIRK2_HOST_NO_CMD23;<br>
<br>
</div></div>Can&#39;t at least some of these be distinguished from what sdh=
ci variant<br>
that is being used? Instead of having them in DT...<br>
<br>
Kind regards<br>
Uffe<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (of_ge=
t_property(np, &quot;no-1-8-v&quot;, NULL))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0host-&gt;quirks2 |=3D SDHCI_QUIRK2_NO_1_8_V;<br>
&gt; --<br>
&gt; 1.8.2.1<br>
&gt;<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-m=
mc&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html<=
/a><br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature"><div dir=3D"ltr"><div>Thanks,</div><div>wi=
th regards,</div>Suman Tripathi</div></div>
</div>

--e89a8f23558151639105134ce1fb--

--===============8323353036308433107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============8323353036308433107==--
