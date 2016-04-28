From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 0/4] mmc: usdhi6rol0: UHS support
Date: Thu, 28 Apr 2016 12:38:23 +0200
Message-ID: <CAPDyKFq=U1YC4OELrD0zb1=2hHHzWomuei2LYDKBYo36v-Fa3A@mail.gmail.com>
References: <cover.1461770066.git.larper@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37532 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752665AbcD1Kia (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2016 06:38:30 -0400
Received: by mail-wm0-f51.google.com with SMTP id a17so57789770wme.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2016 03:38:23 -0700 (PDT)
In-Reply-To: <cover.1461770066.git.larper@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars Persson <lars.persson@axis.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lars Persson <larper@axis.com>

On 27 April 2016 at 17:21, Lars Persson <lars.persson@axis.com> wrote:
> This patch set adds UHS support to the usdhi6rol0 driver, with control of the
> regulator and pin state settings.
>
> Changes since v4:
> - Add a fix patch to remove UHS capabilities that were announced without
>   actual driver support.
>
> Changes since v3:
> - No error print for failure of mmc_regulator_set_vqmmc().
> - Do not set UHS caps if the vqmmc regulator is missing.
> - No not set UHS caps if the no-1-8-v property is set.
>
> Changes since v2:
> - dt: renamed pins_uhs to state_uhs.
> - dt: made default optional in pinctrl-names.
> - dt: document that use of state_uhs also requires a default pin state.
> - add error handling for missing pin states.
>
> Changes since v1:
> - Use mmc_regulator_set_vqmmc().
>
> Lars Persson (4):
>   mmc: dt: usdhi6rol0: add optional pinctrl binding
>   mmc: usdhi6rol0: do not announce UHS capabilities
>   mmc: usdhi6rol0: add support for UHS modes
>   mmc: usdhi6rol0: add pinctrl to set pin drive strength
>
>  .../devicetree/bindings/mmc/usdhi6rol0.txt         |  6 +++
>  drivers/mmc/host/usdhi6rol0.c                      | 60 +++++++++++++++++++++-
>  2 files changed, 65 insertions(+), 1 deletion(-)
>

Thanks, applied for next!

Kind regards
Uffe
