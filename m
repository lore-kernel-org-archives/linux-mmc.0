From: merez@codeaurora.org
Subject: Re: mmc idle time bkops?
Date: Mon, 16 Mar 2015 19:37:45 -0000
Message-ID: <bdb5de1e1c2c1cfacdf02ba8f44025a3.squirrel@www.codeaurora.org>
References: <550098CE.1010407@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54759 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118AbbCPThq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Mar 2015 15:37:46 -0400
In-Reply-To: <550098CE.1010407@yandex.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@yandex.ru>
Cc: Maya Erez <merez@codeaurora.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Nikita,

The patch got stuck for a while as there was a request to use the runtime
PM framework for implementing the idle time BKOPs and I didn't have the
ability to test it back then.
We plan to re-implement and test in the upcoming few months (aim to July).
Do you have a need for this feature in an earlier date or it can wait for
july?

Thanks,
Maya

> Hi
>
> Some months ago, you've been working on "idle time bkops" feature. The
> latest (v6) sign of this work I could found is [1]
>
> [1] https://lkml.org/lkml/2013/4/14/29
>
> However this did not land in mainline, also no replies, and no sign of
> any follow-up...  Complete mystery what has happened to this effort :(
>
> What is the latest status of "idle time bkops" functionality?
> Is any working implementation available?
>
> TIA,
> Nikita Yushchenko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Maya Erez
Qualcomm Israel, on behalf of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
Collaborative Project

