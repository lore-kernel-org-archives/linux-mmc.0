From: NamJae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH] mmc : fix compile error when CONFIG_BLOCK is not enable
Date: Sat, 15 Oct 2011 07:57:54 +0900
Message-ID: <CAKYAXd_9nMJqxUR1YFoHBy+imXU1LHzXG1wFGRnU_Gm=3J06jQ@mail.gmail.com>
References: <4E95D3E3.3030802@xenotime.net>
	<1135697021.85929.1318444482498.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57177 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab1JNXDP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Oct 2011 19:03:15 -0400
Received: by bkbzt19 with SMTP id zt19so523896bkb.19
        for <linux-mmc@vger.kernel.org>; Fri, 14 Oct 2011 16:03:14 -0700 (PDT)
In-Reply-To: <1135697021.85929.1318444482498.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <awarkentin@vmware.com>, Randy Dunlap <rdunlap@xenotime.net>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

2011/10/13 Andrei Warkentin <awarkentin@vmware.com>:
> ----- Original Message -----
>> From: "Randy Dunlap" <rdunlap@xenotime.net>
>> To: "Namjae Jeon" <linkinjeon@gmail.com>
>> Cc: cjb@laptop.org, awarkentin@vmware.com
>> Sent: Wednesday, October 12, 2011 1:52:35 PM
>> Subject: Re: [PATCH] mmc : fix compile error when CONFIG_BLOCK is not enable
>>
>> On 10/12/2011 08:43 AM, Namjae Jeon wrote:
>> > 'DISK_NAME_LEN' undeclared compile error happen when CONFIG_BLOCK
>> > is disable.
>> > because linux/genhd.h is included by general purpose partition
>> > patch.
>> > So I add proper own define MAX_MMC_PART_NAME_LEN instead of using
>> > DISK_NAME_LEN in genhd.h.
>> >
>> > Signed-off-by: Namjae Jeon <linkinjeon@gmail.com>
>>
>> Reported-by: Randy Dunlap <rdunlap@xenotime.net>
>> Acked-by: Randy Dunlap <rdunlap@xenotime.net>
>>
>
> Acked-by: Andrei Warkentin <andreiw@vmware.com>
Thanks  Andrei, Randy.
>
> A
>
