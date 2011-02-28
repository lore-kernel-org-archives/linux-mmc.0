From: Will Newton <will.newton@gmail.com>
Subject: Re: [RFC] dw_mmc: didn't support multiple blocks of weird length?
Date: Mon, 28 Feb 2011 10:45:31 +0000
Message-ID: <AANLkTi=cjeHKnHX0pbEnuaEo4EDj_vECRBDdUtWP9Z9D@mail.gmail.com>
References: <4D675BA4.4040006@samsung.com>
	<AANLkTi=a+4e-DnVNoYjrLzBBzkFMu2yJutpO8kkNnuPm@mail.gmail.com>
	<4D6B0C11.8080503@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56957 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116Ab1B1Kpb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2011 05:45:31 -0500
Received: by pzk35 with SMTP id 35so601625pzk.19
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2011 02:45:31 -0800 (PST)
In-Reply-To: <4D6B0C11.8080503@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chris Ball <cjb@laptop.org>

On Mon, Feb 28, 2011 at 2:44 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Right...maybe not problem merging those two functions.
> But think not use list_add_tail(&slot->queue_node, &host->queue)..
>
> I want to know when use list_add_tail functions..in this code.

I think that code is from the original NXP driver and appears to be
used to support multiple slots attached to the same block (so you can
be asked to process a request for slot A while the block is busy
processing an earlier request for slot B). I don't have any hardware
setup like this, everything I have has only a single slot so I don't
believe I have ever seen that branch of the conditional execute.
