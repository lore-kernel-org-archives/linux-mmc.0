From: Praveen G K <praveen.gk@gmail.com>
Subject: Re: slow eMMC write speed
Date: Wed, 28 Sep 2011 12:06:01 -0700
Message-ID: <CAHzg1A9H31hWdEKR5+_p8HuA_oq6o8EkESpJ22kQ4e4oFDH8GQ@mail.gmail.com>
References: <CAHzg1A9usWP8o3xjEq3yFn56bEqk_Qp0a8-2FJzoRZG1MqPRPA@mail.gmail.com>
	<CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59720 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab1I1TGE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 15:06:04 -0400
Received: by fxe4 with SMTP id 4so876711fxe.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Sep 2011 12:06:02 -0700 (PDT)
In-Reply-To: <CACRpkdYamRVpBbhAcgn7rXBGcgHUp7+9PCrmOUkXV1BvZ+4pDw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org

On Tue, Sep 27, 2011 at 10:42 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Fri, Sep 23, 2011 at 7:05 AM, Praveen G K <praveen.gk@gmail.com> w=
rote:
>
>> I am working on the block driver module of the eMMC driver (SDIO 3.0
>> controller). =A0I am seeing very low write speed for eMMC transfers.=
 =A0On
>> further debugging, I observed that every 63rd and 64th transfer take=
s
>> a long time.
>
> Are you not just seeing the card-internal garbage collection?
> http://lwn.net/Articles/428584/
Does this mean, theoretically, I should be able to achieve larger
speeds if I am not using linux? So, is this a software issue? or if
there is a way to increase the size of bounce buffers to 4MB?

> Yours,
> Linus Walleij
>
