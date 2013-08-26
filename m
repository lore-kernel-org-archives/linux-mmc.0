From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v6 2/3] mmc: dw_mmc: Honor requests to set the clock to 0
 (turn off clock)
Date: Mon, 26 Aug 2013 10:31:11 +0900
Message-ID: <521AAFDF.9090608@samsung.com>
References: <1377188348-3418-1-git-send-email-dianders@chromium.org>
 <1377188348-3418-3-git-send-email-dianders@chromium.org>
 <521761F1.60203@samsung.com>
 <CAD=FV=WrZacm7UUB3-qE=ufwkur_55m0puPNdUaGBYszPw9OdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAD=FV=WrZacm7UUB3-qE=ufwkur_55m0puPNdUaGBYszPw9OdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, James Hogan <james.hogan@imgtec.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Doug,

On 08/24/2013 05:40 AM, Doug Anderson wrote:
> Jaehoon,
> 
> On Fri, Aug 23, 2013 at 6:21 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Doug,
>>
>> If the clock-gating is enabled, then maybe it's continuously printed the kernel message for Bus_speed.
> 
> Can you explain?  I don't think dw_mmc has support for clock gating
> right now.  ...or are there some patches that I'm not aware of?  I
> could believe that if you've got some non-upstream clock gating
> patches that these would need to be modified to handle it...  ...but
> unless those are slated to land upstream it seems like I can't take
> them into account, can I?
If i enabled the CONFIG_MMC_CLK_GATE, the i have found the below message whenever some operation is run.
I will test more with your patch.

[    6.335000] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    6.345000] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    6.355000] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    6.365000] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    6.375000] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    6.480000] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    6.490000] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    6.500000] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    6.530000] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    6.535000] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    6.545000] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)

Best Regards,
Jaehoon Chung
> 
> Thanks!
> 
> -Doug
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
