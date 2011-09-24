From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] MMC: ext_csd.raw_* used in comparison but never set
Date: Sat, 24 Sep 2011 12:14:47 -0400
Message-ID: <m2litdx6h4.fsf@bob.laptop.org>
References: <1316751930-7478-1-git-send-email-andrey.warkentin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52035 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385Ab1IXQPB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 24 Sep 2011 12:15:01 -0400
In-Reply-To: <1316751930-7478-1-git-send-email-andrey.warkentin@gmail.com>
	(Andrei Warkentin's message of "Fri, 23 Sep 2011 00:25:30 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andrey.warkentin@gmail.com>
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>, andreiw@vmware.com

Hi,

On Fri, Sep 23 2011, Andrei Warkentin wrote:
> f39b2dd9d065151a04f5996656d1f27a7eb32d45 added code to
> only compare read-only ext_csd fields in bus width
> testing code, yet it's comparing some fields that are
> never set.
>
> The affected fields are ext_csd.raw_erased_mem_count and
> ext_csd.raw_partition_support.
>
> Signed-off-by: Andrei Warkentin <andrey.warkentin@gmail.com>

Thanks, pushed to mmc-next for 3.2 with a stable@ tag.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
