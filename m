From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 08/11] mmc: pwrseq_simple: Add support for a delay
Date: Thu, 15 Jan 2015 10:33:47 -0700
Message-ID: <54B7F9FB.7030100@wwwdotorg.org>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com> <1421338359-27467-9-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:53030 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbbAORcp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jan 2015 12:32:45 -0500
In-Reply-To: <1421338359-27467-9-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-tegra@vger.kernel.org
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Dylan Reid <dgreid@chromium.org>, Simon Glass <sjg@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chris Ball <chris@printf.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On 01/15/2015 09:12 AM, Tomeu Vizoso wrote:
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Ah, having read the explanation in the next patch, I think ...

> diff --git a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt

> +- delay : delay to wait after driving the reset gpio active [ms].

... delay is the wrong name. reset-pulse-width or reset-pulse-length 
would be better. delay sounds like a delay after resetting the device 
before it can be accessed.
