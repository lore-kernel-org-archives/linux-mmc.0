From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 3/5] mmc: mxcmmc: constify mxcmci_devtype and fix build
 warning
Date: Thu, 14 Mar 2013 19:15:03 +0100
Message-ID: <20130314191503.7e0e4903@crub>
References: <1363279254-22351-1-git-send-email-agust@denx.de>
	<1363279254-22351-5-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:52276 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932979Ab3CNSPB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 14:15:01 -0400
In-Reply-To: <1363279254-22351-5-git-send-email-agust@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>, devicetree-discuss@lists.ozlabs.org

On Thu, 14 Mar 2013 17:40:52 +0100
Anatolij Gustschin <agust@denx.de> wrote:

> Fix:
> drivers/mmc/host/mxcmmc.c: In function 'mxcmci_probe':
> drivers/mmc/host/mxcmmc.c:1137:41: warning: initialization discards
> 'const' qualifier from pointer target type [enabled by default]
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  drivers/mmc/host/mxcmmc.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

that one has been sent by accident, please ignore it.

Sorry for that.

Anatolij
