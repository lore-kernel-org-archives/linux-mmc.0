From: merez@codeaurora.org
Subject: Re: [RFC/PATCH 1/1] mmc: block: Add MMC write packing statistics
Date: Wed, 6 Jun 2012 13:56:13 -0700 (PDT)
Message-ID: <310175ff06fd45dca660047535666a61.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rahul Bedarkar <rpal143@gmail.com>
Cc: Maya Erez <merez@codeaurora.org>, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

>> +
>> + =A0 =A0 =A0 for (i =3D 1 ; i <=3D max_num_of_packed_reqs ; ++i) {
> This is something magical number for iterations. why can not we start
from
> zero.
The statistics are kept in the array in the index that equals the numbe=
r
of packed requests. Therefore, they are kept in the array in indexes 1 =
to
max num of packed reqs.
I will add a comment to explain that.

Thanks,
Maya Erez
Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
