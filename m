From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH v2] mmc: core: select the operation mode with sysfs
Date: Sun, 5 Feb 2012 20:02:55 +0900
Message-ID: <CAELcNGTwOc-e8cO1O2Zk0=B2Dx3MxXqNB7ZGJi8x+UM9GTE7qQ@mail.gmail.com>
References: <4F17B530.6040809@samsung.com>
	<m2mx8y9qfs.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38891 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762Ab2BELC4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Feb 2012 06:02:56 -0500
Received: by bkcjm19 with SMTP id jm19so4054665bkc.19
        for <linux-mmc@vger.kernel.org>; Sun, 05 Feb 2012 03:02:55 -0800 (PST)
In-Reply-To: <m2mx8y9qfs.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>

2012/2/5 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Thu, Jan 19 2012, Jaehoon Chung wrote:
>> This patch is support the sysfs for operation mode.
>>
>> There are two operation modes(open-ended/pre-defined).
>> Now, operation mode is selected only one at the compile time.
>>
>> But using this patch, we can change the operation mode with node at =
runtime.
>>
>> * pre-defined mode
>> echo 1 > /sys/class/mmc_host/mmc0/pre_defined_op
>> * open-ended mode
>> echo 0 > /sys/class/mmc_host/mmc0/pre_defined_op
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> Changelog v2:
>> =A0 =A0 =A0 - Add the check point in mmc_cmd23_store()
>> =A0 =A0 =A0 (If host controller didn't support CMD23, need not to ch=
ange the ops-mode.)
>>
>> =A0drivers/mmc/card/block.c | =A0 14 +++++++-------
>> =A0drivers/mmc/core/host.c =A0| =A0 41 +++++++++++++++++++++++++++++=
++++++++++++
>> =A0include/linux/mmc/host.h | =A0 =A05 ++++-
>> =A03 files changed, 52 insertions(+), 8 deletions(-)
>
> Patches that add sysfs nodes must come with documentation added to
> Documentation/mmc/mmc-dev-attrs.txt.
Hi Chris..
Ok..i will add to mmc-dev-attrs.txt and resend the patch.

Best Regards,
Jaehoon Chung
>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
