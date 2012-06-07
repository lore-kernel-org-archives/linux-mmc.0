From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH v2 1/1] mmc: block: replace __blk_end_request() with blk_end_request()
Date: Thu, 07 Jun 2012 16:16:09 +0530
Message-ID: <4FD08671.9040402@codeaurora.org>
References: <1339064218-31925-1-git-send-email-subhashj@codeaurora.org> <CAKYAXd8VmJEzGG8sd-GJvG9qKGDahmFSBwNxnH3LCocT_F+o2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:33528 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759830Ab2FGKqN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jun 2012 06:46:13 -0400
In-Reply-To: <CAKYAXd8VmJEzGG8sd-GJvG9qKGDahmFSBwNxnH3LCocT_F+o2Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Namjae Jeon <linkinjeon@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

On 6/7/2012 4:05 PM, Namjae Jeon wrote:
> This change is not meant for improving MMC throughput; it's basically
> >  about becoming fair to other threads/interrupts in the system. By holding
> >  spin lock and interrupts disabled for longer duration, we won't allow
> >  other threads/interrupts to run at all.
As i have mentioned in commit text,

This change is not meant for improving MMC throughput; it's basically
about becoming fair to other threads/interrupts in the system. By holding
spin lock and interrupts disabled for longer duration, we won't allow
other threads/interrupts to run at all.

Regards,
Subhash

