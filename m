From: Andrei Warkentin <awarkentin@vmware.com>
Subject: Re: A question on IOCTL interface for MMC
Date: Thu, 20 Oct 2011 07:55:34 -0700 (PDT)
Message-ID: <29942744.123457.1319122534256.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
References: <CANYdXnqDYn5-zehsJ9ibviJ7FoofcY=YLUqrROoK8k53v-czNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:37121 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752950Ab1JTOze (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Oct 2011 10:55:34 -0400
In-Reply-To: <CANYdXnqDYn5-zehsJ9ibviJ7FoofcY=YLUqrROoK8k53v-czNA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Chris Ball <cjb@laptop.org>, J Freyensee <james_p_freyensee@linux.intel.com>, John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org

Hi,

----- Original Message -----
> From: "Shashidhar Hiremath" <shashidharh@vayavyalabs.com>
> To: "Chris Ball" <cjb@laptop.org>, "J Freyensee" <james_p_freyensee@linux.intel.com>, "John Calixto"
> <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org
> Sent: Thursday, October 20, 2011 1:09:00 AM
> Subject: A question on IOCTL interface for MMC
> 
> Hi ,
>   I am planning to use the existing IOCTL interface for SD/MMC
>   present
> in the kernel.
>   Since, the IOCTL interface expects a read/write flag and the MMC
> IOCTL is actually an interface to block layer I feel without
> modifying
> the block layer for the support of non-read write commands ,I may not
> be able to test the non-read/write commands through the IOCTL
> interface .

Unsure what you mean. Certainly it's up to you how to handle the data
you pass to the ioctl(). The "in" and "out" just says whether you
are passing data to the kernel or expecting something back, no more - 
no less.

What are you actually trying to do? What are you trying to expose or control
through an ioctl?

A
