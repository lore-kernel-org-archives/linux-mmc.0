From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [v6, 1/4] mmc: dt: add DT binding for little-endian eSDHC host controller
Date: Thu, 8 Oct 2015 19:36:16 +0200
Message-ID: <CAPDyKFrAacgGvFgcok4gpv4fuw3HrYM96sad-N0Fs5BTSha_iw@mail.gmail.com>
References: <1444300583-26539-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34919 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933271AbbJHRgS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2015 13:36:18 -0400
Received: by wicge5 with SMTP id ge5so36002874wic.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2015 10:36:17 -0700 (PDT)
In-Reply-To: <1444300583-26539-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Li Leo <LeoLi@freescale.com>, Arnd Bergmann <arnd@arndb.de>

On 8 October 2015 at 12:36, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
> Changes for v4:
>         - Added this mmc DT documentation patch
> Changes for v5:
>         - Updated DT documentation fsl-esdhc.txt instead of mmc.txt
>         - Used 'big-endian' as default endian mode
> Changes for v6: None
> ---
>  Documentation/devicetree/bindings/mmc/fsl-esdhc.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> index b7943f3..dedfb02 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-esdhc.txt
> @@ -22,6 +22,8 @@ Optional properties:
>    - voltage-ranges : two cells are required, first cell specifies minimum
>      slot voltage (mV), second cell specifies maximum slot voltage (mV).
>      Several ranges could be specified.
> +  - little-endian : If the host controller is little-endian mode, specify
> +    this property. The default endian mode is big-endian.
>
>  Example:
>
> --
> 2.1.0.27.g96db324
>

Thanks, applied all patches 1->4 for next.

Kind regards
Uffe
