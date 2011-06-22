From: Nickolay Nickolaev <nicknickolaev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 02/11] omap_hsmmc: add support for pre_req and post_req
Date: Wed, 22 Jun 2011 11:51:23 +0300
Message-ID: <BANLkTikqeKg=Mr9BxVYL7x=9k_jzGeLnQQ@mail.gmail.com>
References: <1308699521-20556-1-git-send-email-per.forlin@linaro.org>
	<1308699521-20556-3-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5627541367550495036=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1308699521-20556-3-git-send-email-per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Nicolas Pitre <nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

--===============5627541367550495036==
Content-Type: multipart/alternative; boundary=001636c5c154b666ba04a649122e

--001636c5c154b666ba04a649122e
Content-Type: text/plain; charset=ISO-8859-1

Hello,

this one's causing me compilation trouble troubles when CONFIG_DMA_ENGINE is
not defined.

On Wed, Jun 22, 2011 at 2:38 AM, Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

>
> @@ -2077,6 +2155,7 @@ static int __init omap_hsmmc_probe(struct
> platform_device *pdev)
>        host->mapbase   = res->start;
>        host->base      = ioremap(host->mapbase, SZ_4K);
>        host->power_mode = MMC_POWER_OFF;
> +       host->next_data.cookie = 1;
>
>        platform_set_drvdata(pdev, host);
>        INIT_WORK(&host->mmc_carddetect_work, omap_hsmmc_detect);
> --
> 1.7.4.1
>
>
>
Maybe we can wrap it in a function as the others.

regards,
Nikolay Nikolaev

--001636c5c154b666ba04a649122e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>this one&#39;s causing me compilation trouble troubles when C=
ONFIG_DMA_ENGINE is not defined.<br><br><div class=3D"gmail_quote">On Wed, =
Jun 22, 2011 at 2:38 AM, Per Forlin <span dir=3D"ltr">&lt;<a href=3D"mailto=
:per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org">per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><br>
@@ -2077,6 +2155,7 @@ static int __init omap_hsmmc_probe(struct platform_de=
vice *pdev)<br>
 =A0 =A0 =A0 =A0host-&gt;mapbase =A0 =3D res-&gt;start;<br>
 =A0 =A0 =A0 =A0host-&gt;base =A0 =A0 =A0=3D ioremap(host-&gt;mapbase, SZ_4=
K);<br>
 =A0 =A0 =A0 =A0host-&gt;power_mode =3D MMC_POWER_OFF;<br>
+ =A0 =A0 =A0 host-&gt;next_data.cookie =3D 1;<br>
<br>
 =A0 =A0 =A0 =A0platform_set_drvdata(pdev, host);<br>
 =A0 =A0 =A0 =A0INIT_WORK(&amp;host-&gt;mmc_carddetect_work, omap_hsmmc_det=
ect);<br>
<font color=3D"#888888">--<br>
1.7.4.1<br>
<br>
<br></font></blockquote><br>Maybe we can wrap it in a function as the other=
s.<br><br>regards,<br>Nikolay Nikolaev<br></div>

--001636c5c154b666ba04a649122e--


--===============5627541367550495036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============5627541367550495036==--
