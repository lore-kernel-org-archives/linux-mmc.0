From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [linux-pm] [RFC,PATCHv3 0/3] sdhci runtime_pm implementation
Date: Tue, 1 Mar 2011 20:36:48 +0100
Message-ID: <AANLkTi=ogThxB_2bxANV4hUsLGZs04gzHSCyH90Bm87U@mail.gmail.com>
References: <cover.1298820825.git.tardyp@gmail.com>
	<Pine.LNX.4.44L0.1103011431400.2034-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:49999 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756067Ab1CATgt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2011 14:36:49 -0500
In-Reply-To: <Pine.LNX.4.44L0.1103011431400.2034-100000@iolanthe.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org

On Tue, Mar 1, 2011 at 8:33 PM, Alan Stern <stern@rowland.harvard.edu> =
wrote:
> On Tue, 1 Mar 2011, Pierre Tardy wrote:
>
>> Please find sdhci runtime_pm implementation.
>>
>> It uses clock gating fw as a tip to know when our chip is idle.
>> It implements wake up from card insertion/removal.
>>
>> This is RFC, please dont merge yet. I really would like to have deep=
 review
>> from PCI linux-pm guys.
>>
>> Opens are:
>>
>> 1/ Not sure if the pci configs in the driver in rpm_suspend/resume f=
low
>> =A0are not duplicate from what the core is doing.
>
> There may be one or two small errors.
>
>> 2/ Wakeup from D3hot: I cannot find any driver that is implementing =
it in current upstream,
>
> Other drivers do it, but they use PCI PME# instead of interrupts.
Could you please elaborate?
My understanding is that PCI PME will generate MSI, which translate in
interrupt.

Thanks
Pierre
