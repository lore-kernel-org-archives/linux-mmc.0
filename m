From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: add missing inclusion of linux/module.h
Date: Mon, 15 Aug 2011 13:35:58 +0800
Message-ID: <CAAQ0ZWRX_POwMZY9m9ath=oC0OS538+wRcfj-vay5VSkSRkzEg@mail.gmail.com>
References: <1313375298-18546-1-git-send-email-shawn.guo@linaro.org>
	<m2mxfbmirn.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <m2mxfbmirn.fsf@bob.laptop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

On 15 August 2011 11:54, Chris Ball <cjb@laptop.org> wrote:
> Hi Shawn,
>
> On Sun, Aug 14 2011, Shawn Guo wrote:
>> There are following warning and error when compiling the driver.
>> The patch adds the missing inclusion of linux/module.h to fix them.
>>
>> drivers/mmc/host/sdhci-esdhc-imx.c:87:1: warning: data definition ha=
s
>> no type or storage class
>
> Pushed to mmc-next for 3.1. =A0I don't see these on my imx build with
> CONFIG_MMC_SDHCI_ESDHC_IMX=3Dm, so it'd be useful to see your .config
> so that I'm able to reproduce in future.
>
I guess it's not about .config but sources.  I spot this on
linux-next-20110812.  Are you trying the same tree?  I will test
v3.1-rc2 tag when I can actually fetch it.  (Linus released it, but it
has not been available with 'git fetch' yet.)

--=20
Regards,
Shawn
