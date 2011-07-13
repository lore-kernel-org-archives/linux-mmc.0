From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH] mmc: block: fixed NULL pointer dereference
Date: Wed, 13 Jul 2011 11:56:08 +0200
Message-ID: <CAJ0pr19vheoBHvUd=0359bKvjKe3+Dao2vpenJ90tLXL_Dtc_w@mail.gmail.com>
References: <4E1D5108.8040309@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:65119 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965171Ab1GMJ4J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2011 05:56:09 -0400
Received: by qwk3 with SMTP id 3so2773179qwk.19
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2011 02:56:08 -0700 (PDT)
In-Reply-To: <4E1D5108.8040309@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Philip Rakity <prakity@marvell.com>

On 13 July 2011 10:02, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi.
>
> I send to mailing for [RFC] Kernel NULL pointer dereference.
> This patch is fixed it.
>
> In similar case, when discard request, check condition and
> performed mmc_blk_issue_rw_rq(mq, NULL) for ongoing async transfer.
>
> But When flush request, entered the mmc_blk_issue_flush() then return=
=2E
> (then didn't complete ongoing aync transfer).
>
> I think that need to complete for ongoing aync transfer before flush =
request.
>
I did consider this when I added the check for discard but I didn't
realize it is necessary for flush too.
There is no real downside of completing the async request before flush
in terms of performance anyway.

Thanks for catching this bug.

> @@ -1200,6 +1200,9 @@ static int mmc_blk_issue_rq(struct mmc_queue *m=
q, struct request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D mmc_blk_issue_=
discard_rq(mq, req);
> =A0 =A0 =A0 =A0} else if (req && req->cmd_flags & REQ_FLUSH) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* complete ongoing async transfer befo=
re issuing flush */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->host->areq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_blk_issue_rw_rq(mq,=
 NULL);
These 2 lines are the same as for the discard condition. I still
prefer 2 lines of repeating code rather than one big if-statement
covering both discard and flush.

Acked-by: Per Forlin <per.forlin@linaro.org>

Regards,
Per
