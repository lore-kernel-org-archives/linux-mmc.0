From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6 13/14] mmc: sdhci: solve several vmmc/vqmmc regulator issues
Date: Sat, 17 Nov 2012 18:02:55 -0500
Message-ID: <87r4nr7rz4.fsf@octavius.laptop.org>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-14-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54562 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab2KQXDC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 18:03:02 -0500
In-Reply-To: <1350471893-29633-14-git-send-email-keyuan.liu@gmail.com> (Kevin
	Liu's message of "Wed, 17 Oct 2012 19:04:52 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

Hi,

On Wed, Oct 17 2012, Kevin Liu wrote:
> From: Kevin Liu <kliu5@marvell.com>
>
> 1. The vmmc regulator enable in sdhci_add_host is NOT necessary since
> it can be enabled during mmc_power_up by function mmc_regulator_set_ocr.
> And this extra enable will make regulator_enable/regulator_disable
> unbalanced. Consequently, vmmc can't be disabled during mmc_power_off.
>
> 2. If regulator vqmmc exist, it should be enabled regardless it support
> 1.8v or not.
>
> 3. If regulator framework is disabled, regulator_get will return NULL.
> So the CONFIG_REGULATOR judgement can be removed.

Pushed to mmc-next for 3.8 without "3." above, because it causes a
compile error -- now we use regulator_count_voltages() inside that
block and it's not a stub function in the regulator API, so the
ifdef is required.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
