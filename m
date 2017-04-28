From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH 1/3] mmc: sdio: Add API to manage SDIO IRQs from a workqueue
Date: Fri, 28 Apr 2017 13:31:33 -0700
Message-ID: <CAD=FV=WM_c+bXtraybrKbT_fuVk2jzor8vMjpnrRAQ2R79u_VA@mail.gmail.com>
References: <1492518724-30511-1-git-send-email-ulf.hansson@linaro.org>
 <1492518724-30511-2-git-send-email-ulf.hansson@linaro.org>
 <CAD=FV=XMk4+86WaCWjuf3NVwRoEubjcY+zQhH-hsb=H3sRpw0A@mail.gmail.com>
 <CAPDyKFqruAXXnp_=6u4i5DnXpjvO_YkCiv-PjooaSQXqjn9z-A@mail.gmail.com>
 <CAD=FV=XX-LRdNQytWDQ5N5qEtNQyQH1kmU9KUaT1EnKWG1EvtA@mail.gmail.com> <CAPDyKFo2_qM9cxSu6Q=f1C1SdnQ4WPe_pR4Y4ypSotwc4Jc8gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35808 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030850AbdD1Ubg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Apr 2017 16:31:36 -0400
Received: by mail-yw0-f178.google.com with SMTP id u70so36425547ywe.2
        for <linux-mmc@vger.kernel.org>; Fri, 28 Apr 2017 13:31:35 -0700 (PDT)
In-Reply-To: <CAPDyKFo2_qM9cxSu6Q=f1C1SdnQ4WPe_pR4Y4ypSotwc4Jc8gA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Brian Norris <briannorris@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>

Ulf

On Thu, Apr 20, 2017 at 5:14 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>
>> With "cap-sdio-irq" commented out but without your 3 patches:
>> => Boot up, "ifconfig eth0 down; ping -c 20 8.8.8.8".  Seems OK.
>>
>> With "cap-sdio-irq" commented out but _with_ your 3 patches:
>> => Boot up, "ifconfig eth0 down; ping -c 20 8.8.8.8".  Seems OK.
>>
>> So I guess the conclusion is that I missed the part about your patch
>> only enabling the new features if MMC_CAP_SDIO_IRQ.  Sorry.  :(
>> ...and then I must have hit some other unrelated failure that I can't
>> reproduce now and assumed it was your patch's fault.
>>
>> So basically I would say that I've lightly tested your code.  It's not
>> code I've stressed a ton, but it survived some basic tests anyway...
>> :)  The code also looks pretty sane to me.
>
> Thanks a lot for your feedback a for running a new round of tests.
> This seems promising then!
>
> When you have the time, it we awesome if you could run yet another new
> round of test with the new version of the series. I posted it
> yesterday evening my local time.

Sorry for taking so long to get to this.  I've done this now and
things seem to be working fine with your new series.  As with before,
I'm not doing really stressful testing here, but what I've done seems
OK.


> I would also be very interested to know if converting to the work
> queue approach has any impact on throughput. Maybe you have some
> simple test suite to also verify that?

I don't personally.  To really get something repeatable for WiFi, you
need things in a chamber and need a test server setup.

I did this quick test with the device sitting on my desk (with
whatever the closest WiFi access point was), though:

ifconfig eth0 down
for i in $(seq 5); do
  curl http://SomeBigFile > /dev/null
done


>From this very simple test, the performance looks like a wash.

--

Before your changes:

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 54.0M  100 54.0M    0     0  2753k      0  0:00:20  0:00:20 --:--:-- 2952k
100 54.0M  100 54.0M    0     0  1073k      0  0:00:51  0:00:51 --:--:--  902k
100 54.0M  100 54.0M    0     0  2494k      0  0:00:22  0:00:22 --:--:-- 3061k
100 54.0M  100 54.0M    0     0  2455k      0  0:00:22  0:00:22 --:--:-- 2890k
100 54.0M  100 54.0M    0     0  1934k      0  0:00:28  0:00:28 --:--:-- 2301k

After your changes:

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 54.0M  100 54.0M    0     0  2376k      0  0:00:23  0:00:23 --:--:-- 2739k
100 54.0M  100 54.0M    0     0  2303k      0  0:00:24  0:00:24 --:--:-- 2698k
100 54.0M  100 54.0M    0     0  2512k      0  0:00:22  0:00:22 --:--:-- 2359k
100 54.0M  100 54.0M    0     0  1774k      0  0:00:31  0:00:31 --:--:-- 1742k
100 54.0M  100 54.0M    0     0  2124k      0  0:00:26  0:00:26 --:--:-- 2753k

--

It's possible that Brian Norris (CCed) might have an easy way to do a
better test?

-Doug
