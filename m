From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: help with 'discard' mount option on eMMC
Date: Thu, 10 Oct 2013 14:17:56 +0300
Message-ID: <52568CE4.3040801@codeaurora.org>
References: <loom.20131010T083357-685@post.gmane.org> <52566B05.3000204@codeaurora.org> <loom.20131010T112824-880@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:36680 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900Ab3JJLSB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Oct 2013 07:18:01 -0400
In-Reply-To: <loom.20131010T112824-880@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hello,

On 10/10/13 12:40, Prasanna NAVARATNA wrote:
>> Hello,
>> Could you please post kernel log of such failure?
>> What hw are you using?
> I'm using sdhci controller. Hynix eMMC4.41. Linux Kernel 3.4.5
> There are no kernel log failures as such.
I need it to understand the flow. Also - how exactly reboot done? Is it 
urgent reboot with no fs sync?

> Do we need to have BKOPS in eMMC and wait for BKOPS to complete before
> shutting down? (Or)
BKOPS itself when disabled impact on busy time for write commands.


-- 
sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation


