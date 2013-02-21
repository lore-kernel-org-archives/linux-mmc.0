From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [PATCH v2] mmc: mxcmmc: fix bug that may block a data transfer forever.
Date: Thu, 21 Feb 2013 13:32:08 +0100
Message-ID: <CACKLOr0vTr=8F7Ly_bQCL5FLWhn8hqmsLaUeGfDUMM7OaEqWOg@mail.gmail.com>
References: <1347014617-16238-1-git-send-email-javier.martin@vista-silicon.com>
	<20130219151414.2aa318d7@crub>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:43089 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab3BUMcK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Feb 2013 07:32:10 -0500
Received: by mail-we0-f181.google.com with SMTP id t44so7561274wey.40
        for <linux-mmc@vger.kernel.org>; Thu, 21 Feb 2013 04:32:08 -0800 (PST)
In-Reply-To: <20130219151414.2aa318d7@crub>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-mmc@vger.kernel.org, viresh.linux@gmail.com, g.liakhovetski@gmx.de, vinod.koul@linux.intel.com, s.hauer@pengutronix.de, cjb@laptop.org, fabio.estevam@freescale.com, gcembed@gmail.com

Hi,

On 19 February 2013 15:14, Anatolij Gustschin <agust@denx.de> wrote:
> On Fri,  7 Sep 2012 12:43:37 +0200
> Javier Martin <javier.martin@vista-silicon.com> wrote:
> ...
>> +static void mxcmci_dma_callback(void *data)
>> +{
>> +     struct mxcmci_host *host = data;
>> +     u32 stat;
>> +
>> +     del_timer(&host->watchdog);
>> +
>> +     stat = readl(host->base + MMC_REG_STATUS);
>> +     writel(stat & ~STATUS_DATA_TRANS_DONE, host->base + MMC_REG_STATUS);
>> +
>> +     dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
>> +
>> +     if (stat & STATUS_READ_OP_DONE)
>> +             writel(STATUS_READ_OP_DONE, host->base + MMC_REG_STATUS);
>> +
>> +     mxcmci_data_done(host, stat);
>
> this change introduces a race condition for host->req (and maybe
> for host->data) accesses. The callback is running in soft-irq context and can
> be interrupted by the mxcmci_irq() interrupt which can finish the request and
> set host->req to NULL. Then mxcmci_data_done() crashes with a null pointer
> dereference. How extensively was it tested?

It was tested executing a loop with bonnie++ for a week.
I didn't notice the race condition. Have you had real issues or just
found  it by analysing the code?

Regards.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
