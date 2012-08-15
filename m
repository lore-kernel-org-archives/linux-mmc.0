From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/2] drivers/mfd: Add realtek pcie card reader driver
Date: Wed, 15 Aug 2012 06:40:54 +0000
Message-ID: <201208150640.54561.arnd@arndb.de>
References: <cover.1344939464.git.wei_wang@realsil.com.cn> <81fef7d4f337f6d8e3365752bbb3ef87302b82a0.1344939464.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57885 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab2HOGlM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Aug 2012 02:41:12 -0400
In-Reply-To: <81fef7d4f337f6d8e3365752bbb3ef87302b82a0.1344939464.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: gregkh@linuxfoundation.org, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, sameo@linux.intel.com, bp@alien8.de, Tejun Heo <tj@kernel.org>

On Tuesday 14 August 2012, wei_wang@realsil.com.cn wrote:
> +
> +void rtsx_pci_start_run(struct rtsx_pcr *pcr)
> +{
> +       /* If pci device removed, don't queue idle work any more */
> +       if (pcr->remove_pci)
> +               return;
> +
> +       if (pcr->state != PDEV_STAT_RUN) {
> +               pcr->state = PDEV_STAT_RUN;
> +               pcr->ops->enable_auto_blink(pcr);
> +       }
> +
> +       mod_timer(&pcr->idle_timer, jiffies + msecs_to_jiffies(200));
> +}
> +EXPORT_SYMBOL_GPL(rtsx_pci_start_run);

One more comment on the mod_timer/queue_work combination: I just saw that
Tejun Heo posted a series to introduce a new mod_delayed_work() helper.

Once that goes in, it would be best to start using it here.

	Arnd
