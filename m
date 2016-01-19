From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [LINUX PATCH 2/5] Documentation: mmc: Updated the binding doc
 for Arasan SDHCI.
Date: Tue, 19 Jan 2016 08:50:57 -0800
Message-ID: <20160119165057.GN6491@xsjsorenbubuntu>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
 <1453213055-35563-2-git-send-email-lakshmis@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1453213055-35563-2-git-send-email-lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: P L Sai Krishna <lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hao <haokexin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Emil Lenchak <emill-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, Tobias Klauser <tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Ivan T. Ivanov" <ivan.ivanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Vincent Yang <vincent.yang.fujitsu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Haibo Chen <haibo.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, "ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc@vger
List-Id: linux-mmc@vger.kernel.org

On Tue, 2016-01-19 at 07:47PM +0530, P L Sai Krishna wrote:
> This patch adds broken-tuning property to the binding
> doc for Arasan SDHCI.
>=20
> Signed-off-by: P L Sai Krishna <lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b=
/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> index da541c3..2088d9f 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> @@ -17,6 +17,10 @@ Required Properties:
>    - interrupt-parent: Phandle for the interrupt controller that serv=
ices
>  		      interrupts for this device.
> =20
> +Optional Properties:
> +  - broken-tuning: Indicates tuning broken in Silicon 1.0 of
> +			  Zynq Ultrascale+ MPSoC.

Describe the purpose/values of the property without reference to the
SoC. Other broken implementations would want to use this property too.

	S=C3=B6ren
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
