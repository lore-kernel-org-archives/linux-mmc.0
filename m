From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: core: Support packed command for eMMC4.5 device
Date: Wed, 25 Jan 2012 14:31:00 +0900
Message-ID: <CAKYAXd_jdGfpC9kcYht=qnfaTPwE+YEx1fo89GkpRyWcN6igig@mail.gmail.com>
References: <002701ccd728$edab9350$c902b9f0$%jun@samsung.com>
	<CAKLKtzddDXhbT6o8XUsMxad9+_a_StJCQz+eBnfQ+q+xLuJQKg@mail.gmail.com>
	<CAKYAXd8A70X1gb-NFHVDMXd-aSG6+Y3PWvRTZDMT3-Ze3aF5Yw@mail.gmail.com>
	<002501ccdb20$c98b2e80$5ca18b80$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63883 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab2AYFiN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Jan 2012 00:38:13 -0500
In-Reply-To: <002501ccdb20$c98b2e80$5ca18b80$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Saugata Das <saugata.das@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org

>> >> +
>> >> +static int mmc_blk_issue_packed_rd(struct mmc_queue *mq,
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct mmc_que=
ue_req *mq_rq)
>> >> +{
>> >> + =C2=A0 =C2=A0 =C2=A0 struct mmc_blk_data *md =3D mq->data;
>> >> + =C2=A0 =C2=A0 =C2=A0 struct mmc_card *card =3D md->queue.card;
>> >> + =C2=A0 =C2=A0 =C2=A0 int status, ret =3D -EIO, retry =3D 2;
Hi. Seungwon.
=46irst Thansk for your reply.
There is one more my review comment.
I think that EIO of ret is not needed. there is no case to be skipped
if/ese condition in do while loop.
