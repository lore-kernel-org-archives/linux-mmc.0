From: Sangwook Lee <sangwook.lee-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: SAMSUNG: Add pm_caps into platform data
Date: Tue, 15 Nov 2011 10:36:53 +0000
Message-ID: <CADPsn1bYO9auMnuv+Mu+f_-8Fz_Rs_uaXGY32WODkO7h2oiPdg@mail.gmail.com>
References: <1320685522-17481-1-git-send-email-sangwook.lee@linaro.org>
	<1320685522-17481-2-git-send-email-sangwook.lee@linaro.org>
	<005c01cca37c$7b8afc00$72a0f400$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6854038739411755219=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <005c01cca37c$7b8afc00$72a0f400$%kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Sangwook Lee <sangwook.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--===============6854038739411755219==
Content-Type: multipart/alternative; boundary=bcaec520eaafd8353e04b1c390a4

--bcaec520eaafd8353e04b1c390a4
Content-Type: text/plain; charset=ISO-8859-1

Hi

On 15 November 2011 09:53, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:

> Sangwook Lee wrote:
> >
> > Add pm_caps into platform_data. This is power management, usually
> > for SDIO device such as SDIO WLAN.
> >
> > Signed-off-by: Sangwook Lee <sangwook.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  arch/arm/plat-samsung/dev-hsmmc3.c         |    2 ++
> >  arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
> >  2 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c
> b/arch/arm/plat-samsung/dev-
> > hsmmc3.c
> > index ede776f..8f467f2 100644
> > --- a/arch/arm/plat-samsung/dev-hsmmc3.c
> > +++ b/arch/arm/plat-samsung/dev-hsmmc3.c
> > @@ -78,6 +78,8 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platdata
> *pd)
> >               set->cfg_card = pd->cfg_card;
> >       if (pd->host_caps)
> >               set->host_caps |= pd->host_caps;
> > +     if (pd->pm_caps)
> > +             set->pm_caps |= pd->pm_caps;
> >       if (pd->clk_type)
> >               set->clk_type = pd->clk_type;
> >  }
> > diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-
> > samsung/include/plat/sdhci.h
> > index 058e096..35646de 100644
> > --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> > +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> > @@ -40,6 +40,7 @@ enum clk_types {
> >   * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
> >   * @max_width: The maximum number of data bits supported.
> >   * @host_caps: Standard MMC host capabilities bit field.
> > + * @pm_caps: SDIO host PM capabilities bit field.
> >   * @cd_type: Type of Card Detection method (see cd_types enum above)
> >   * @clk_type: Type of clock divider method (see clk_types enum above)
> >   * @ext_cd_init: Initialize external card detect subsystem. Called on
> > @@ -67,6 +68,7 @@ enum clk_types {
> >  struct s3c_sdhci_platdata {
> >       unsigned int    max_width;
> >       unsigned int    host_caps;
> > +     unsigned int    pm_caps;
> >       enum cd_types   cd_type;
> >       enum clk_types  clk_type;
> >
> > --
> > 1.7.4.1
>
> Hi Sangwook,
>
> I think you need to re-work based on latest my for-next.
>
>
Ok, I will rebase and then it again



> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>

--bcaec520eaafd8353e04b1c390a4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi <br><br><div class=3D"gmail_quote">On 15 November 2011 09:53, Kukjin Kim=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">kgene.kim@s=
amsung.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div><div></div><div class=3D"h5">Sangwook Lee wrote:<br>
&gt;<br>
&gt; Add pm_caps into platform_data. This is power management, usually<br>
&gt; for SDIO device such as SDIO WLAN.<br>
&gt;<br>
&gt; Signed-off-by: Sangwook Lee &lt;<a href=3D"mailto:sangwook.lee@samsung=
.com">sangwook.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; =A0arch/arm/plat-samsung/dev-hsmmc3.c =A0 =A0 =A0 =A0 | =A0 =A02 ++<br=
>
&gt; =A0arch/arm/plat-samsung/include/plat/sdhci.h | =A0 =A02 ++<br>
&gt; =A02 files changed, 4 insertions(+), 0 deletions(-)<br>
&gt;<br>
&gt; diff --git a/arch/arm/plat-samsung/dev-hsmmc3.c<br>
b/arch/arm/plat-samsung/dev-<br>
&gt; hsmmc3.c<br>
&gt; index ede776f..8f467f2 100644<br>
&gt; --- a/arch/arm/plat-samsung/dev-hsmmc3.c<br>
&gt; +++ b/arch/arm/plat-samsung/dev-hsmmc3.c<br>
&gt; @@ -78,6 +78,8 @@ void s3c_sdhci3_set_platdata(struct s3c_sdhci_platda=
ta<br>
*pd)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 set-&gt;cfg_card =3D pd-&gt;cfg_card;<br>
&gt; =A0 =A0 =A0 if (pd-&gt;host_caps)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 set-&gt;host_caps |=3D pd-&gt;host_caps;<b=
r>
&gt; + =A0 =A0 if (pd-&gt;pm_caps)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 set-&gt;pm_caps |=3D pd-&gt;pm_caps;<br>
&gt; =A0 =A0 =A0 if (pd-&gt;clk_type)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 set-&gt;clk_type =3D pd-&gt;clk_type;<br>
&gt; =A0}<br>
&gt; diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/pla=
t-<br>
&gt; samsung/include/plat/sdhci.h<br>
&gt; index 058e096..35646de 100644<br>
&gt; --- a/arch/arm/plat-samsung/include/plat/sdhci.h<br>
&gt; +++ b/arch/arm/plat-samsung/include/plat/sdhci.h<br>
&gt; @@ -40,6 +40,7 @@ enum clk_types {<br>
&gt; =A0 * struct s3c_sdhci_platdata() - Platform device data for Samsung S=
DHCI<br>
&gt; =A0 * @max_width: The maximum number of data bits supported.<br>
&gt; =A0 * @host_caps: Standard MMC host capabilities bit field.<br>
&gt; + * @pm_caps: SDIO host PM capabilities bit field.<br>
&gt; =A0 * @cd_type: Type of Card Detection method (see cd_types enum above=
)<br>
&gt; =A0 * @clk_type: Type of clock divider method (see clk_types enum abov=
e)<br>
&gt; =A0 * @ext_cd_init: Initialize external card detect subsystem. Called =
on<br>
&gt; @@ -67,6 +68,7 @@ enum clk_types {<br>
&gt; =A0struct s3c_sdhci_platdata {<br>
&gt; =A0 =A0 =A0 unsigned int =A0 =A0max_width;<br>
&gt; =A0 =A0 =A0 unsigned int =A0 =A0host_caps;<br>
&gt; + =A0 =A0 unsigned int =A0 =A0pm_caps;<br>
&gt; =A0 =A0 =A0 enum cd_types =A0 cd_type;<br>
&gt; =A0 =A0 =A0 enum clk_types =A0clk_type;<br>
&gt;<br>
&gt; --<br>
&gt; 1.7.4.1<br>
<br>
</div></div>Hi Sangwook,<br>
<br>
I think you need to re-work based on latest my for-next.<br>
<br></blockquote><div><br>Ok, I will rebase and then it again<br><br>=A0<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex=
; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
Thanks.<br>
<br>
Best regards,<br>
Kgene.<br>
<font color=3D"#888888">--<br>
Kukjin Kim &lt;<a href=3D"mailto:kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org">kgene.kim@samsung.c=
om</a>&gt;, Senior Engineer,<br>
SW Solution Development Team, Samsung Electronics Co., Ltd.<br>
<br>
</font></blockquote></div><br>

--bcaec520eaafd8353e04b1c390a4--


--===============6854038739411755219==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============6854038739411755219==--
