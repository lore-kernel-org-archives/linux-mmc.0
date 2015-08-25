From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v2] mmc: host: use of_property_read_bool()
Date: Tue, 25 Aug 2015 19:32:39 +0300
Message-ID: <55DC98A7.5000202@cogentembedded.com>
References: <3376063.1JTtbbjJ3D@wasted.cogentembedded.com>
 <CAPDyKFrBoa6Jdg6qpYV2UXKgm11q-CQu33j0JCnFkXOsURhtYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrBoa6Jdg6qpYV2UXKgm11q-CQu33j0JCnFkXOsURhtYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 08/25/2015 03:05 PM, Ulf Hansson wrote:

>> Use more compact of_property_read_bool() calls instead of the of_find_property()
>> calls.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Thanks, applied for next!

    Thanks to you! :-)

> Next, time please run checkpatch to remove errors/warnings.

    Hum, I just did and the patch seems clean:

[headless@wasted mmc]$ scripts/checkpatch.pl 
patches/mmc-host-use-of_property_read_bool.patch
total: 0 errors, 0 warnings, 81 lines checked

patches/mmc-host-use-of_property_read_bool.patch has no obvious style problems 
and is ready for submission.

    What do you mean?

> Kind regards
> Uffe

MBR, Sergei
