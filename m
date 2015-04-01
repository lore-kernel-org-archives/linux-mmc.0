From: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mmc: sdhci-tegra: convert to use GPIO descriptors
Date: Wed, 1 Apr 2015 19:43:34 +0900
Message-ID: <CAAVeFuKNB_W8du4Cxr3cTtFMGUBxp1m4bLmN0+DhNqvR+p47+w@mail.gmail.com>
References: <1427751565-30377-1-git-send-email-josserand.mylene@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1427751565-30377-1-git-send-email-josserand.mylene-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mylene JOSSERAND <josserand.mylene-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Mar 31, 2015 at 6:39 AM, Mylene JOSSERAND
<josserand.mylene-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Modify the driver to handle GPIOs using the descriptor API.

Reviewed-by: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Tested-by: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Both the eMMC (not using power GPIO) and SD slot (using power GPIO) of
my Jetson are happy with this patch. While reviewing it I also noticed
that it improves error handling: any error returned by
of_get_named_gpio(), including -EPROBE_DEFER, were ignored and and
driver would successfully probe without powering the controller.
