From: Andy Ross <andy.ross@windriver.com>
Subject: Re: [PATCH] mmc: core: Allow sdio operations in other thread during
 sdio_add_func()
Date: Tue, 15 Feb 2011 11:26:20 -0800
Message-ID: <4D5AD35C.80004@windriver.com>
References: <loom.20110212T012443-915@post.gmane.org>	<AANLkTimyc-sXEhnPtCjQwHbEsdnwGY-ss6SoRSqDOD+d@mail.gmail.com> <AANLkTinJg2t5tM6+PjUF6jbfCWZfXAG2tObXnbdbn=55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from li44-10.members.linode.com ([72.14.181.10]:44030 "EHLO
	plausible.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755645Ab1BOTgl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Feb 2011 14:36:41 -0500
In-Reply-To: <AANLkTinJg2t5tM6+PjUF6jbfCWZfXAG2tObXnbdbn=55@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org

On 02/15/2011 10:08 AM, Dmitry Shmidt wrote:
> mmc: core: Allow sdio operations in other thread during sdio_add_func()
>
> This is important when wlan driver is doing sdio operations from another
> thread during initialization.
> This behavior was introduced as a side-effect in patch
> 807e8e40673d9628fa7dcdd14423424b4ee5f43b

That patch made similar to mmc_attach_sd() and mmc_attach_mmc().  Do
they need to be audited for the same lock contention?

Andy
