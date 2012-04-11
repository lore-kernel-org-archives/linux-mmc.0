From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: core: skip card initialization if power class
 selection fails
Date: Wed, 11 Apr 2012 18:12:49 +0900
Message-ID: <CAKYAXd9_m0mNLU_Ke53dqKVB18mF8u=4zOqmAK=1SuNz4pQnrw@mail.gmail.com>
References: <1333976419-2018-1-git-send-email-subhashj@codeaurora.org>
	<CAKYAXd_F1ZpR3uYFM9fQUnFKRULKw8o3UO7Zw29MG5BsRuXCew@mail.gmail.com>
	<87ehrvwu3y.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60372 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab2DKJMu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Apr 2012 05:12:50 -0400
Received: by iagz16 with SMTP id z16so1010337iag.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 Apr 2012 02:12:49 -0700 (PDT)
In-Reply-To: <87ehrvwu3y.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, linux-mmc@vger.kernel.org, saugata.das@linaro.org

Hi. Chris.

You're right~ we can optmize code properly by moving printk to
mmc_select_powerclass.
Thanks for your reply.

2012/4/10 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Mon, Apr 09 2012, Namjae Jeon wrote:
>> Hi Subhash.
>> There are duplicate printks in three places. Is there no way to avoi=
d
>> duplicate printks ?
>
> The printk can go just before the final "return err" in
> mmc_select_powerclass().
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =C2=A0 <cjb@laptop.org> =C2=A0 <http://printf.net/>
> One Laptop Per Child
