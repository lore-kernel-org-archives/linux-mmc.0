From: Will Newton <will.newton@gmail.com>
Subject: Re: [RFC] dw_mmc: didn't support multiple blocks of weird length?
Date: Fri, 25 Feb 2011 17:55:09 +0000
Message-ID: <AANLkTi=a+4e-DnVNoYjrLzBBzkFMu2yJutpO8kkNnuPm@mail.gmail.com>
References: <4D675BA4.4040006@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41947 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756020Ab1BYRzK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Feb 2011 12:55:10 -0500
Received: by yxs7 with SMTP id 7so818919yxs.19
        for <linux-mmc@vger.kernel.org>; Fri, 25 Feb 2011 09:55:09 -0800 (PST)
In-Reply-To: <4D675BA4.4040006@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>, Chris Ball <cjb@laptop.org>

On Fri, Feb 25, 2011 at 7:35 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi..
>
> I didn't understand this point..
> Plz let me explain this code..
> why need this function (dw_mci_queue_request(host, slot, mrq)?

I don't think there would be any problem merging those two functions.
Also I would be happy to see the comment deleted, it doesn't really
make sense.
