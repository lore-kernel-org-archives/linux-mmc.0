From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH 2/2] mmc: Remove dead code
Date: Thu, 10 May 2012 09:48:05 +0900
Message-ID: <CAKYAXd_fmECB8MJGtUd3b2GbkHGuLvf2=u-6EjMB=ndBjKjg0Q@mail.gmail.com>
References: <1334176325-6221-1-git-send-email-philippedeswert@gmail.com>
	<CAKYAXd8Uor+AM2vf8ZEUsNKef=QbMnExGe47o1m9YMxzQ9ZokQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:44533 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab2EJAsG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 May 2012 20:48:06 -0400
Received: by werb10 with SMTP id b10so577245wer.19
        for <linux-mmc@vger.kernel.org>; Wed, 09 May 2012 17:48:05 -0700 (PDT)
In-Reply-To: <CAKYAXd8Uor+AM2vf8ZEUsNKef=QbMnExGe47o1m9YMxzQ9ZokQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Philippe De Swert <philippedeswert@gmail.com>

Hi. Chris.

Would you check this patch also ?

Thanks.

2012/4/12, Namjae Jeon <linkinjeon@gmail.com>:
> 2012/4/12 Philippe De Swert <philippedeswert@gmail.com>:
>> bus_width is passed to the function and when 0 (MMC_BUS_WIDTH_1)
>> will cause the function to return. So in in the second test it
>> definitly is different from 0, and the third test is redundant.
>>
>> Signed-off-by: Philippe De Swert <philippedeswert@gmail.com>
>> ---
> Looks good to me.
> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
>
