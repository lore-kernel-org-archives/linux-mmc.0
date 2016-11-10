From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v8 0/6] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Thu, 10 Nov 2016 23:21:08 +0100
Message-ID: <CAPDyKFq-tZheBD_dqkKDeKy11r1UZGt2_NRpFYCqw0SsC-hBJw@mail.gmail.com>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au> <20161110114549.GC1436@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161110114549.GC1436@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 10 November 2016 at 12:45, Wolfram Sang <wsa@the-dreams.de> wrote:
> On Thu, Nov 03, 2016 at 03:15:58PM +0100, Simon Horman wrote:
>> Hi,
>>
>> this series is based on work by Ai Kyuse to add UHS-I SDR-104 support for
>> sh_mobile_sdhi. It builds on work by Shinobu Uehara, Rob Taylor, William
>> Towle and Ian Molton, Ben Hutchings, Wolfram Sang and others to add UHS-I
>> SDR-50 support to the same driver.
>>
>> It is based on the next branch of the mmc tree.
>>
>> To aid review the following git branch is provided:
>> * https:://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/sdr104-driver-v8
>>
>> Overview of changes since v7:
>> * Correct inverted logic in sh_mobile_sdhi_hw_reset
>> * Correct value of SH_MOBILE_SDHI_SCC_RVSCNTL_RVSEN
>>
>> Please see http://elinux.org/Tests:SD-SDHI-SDR104 for indicative tests
>> results.
>
> Successfully tested on a Lager Board with a SanDisk card and a Samsung
> card which used to cause issues before.
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Ulf, I think this series is ready to go for v4.10. All issues we know of
> are related to pinmuxing and will be solved elsewhere. We currently have
> hacks for that so it is quite clear the issues are not caused by this
> series.
>

Thanks, applied for next!

I did have to fix conflict and also to resolve some checkpatch
warnings - but no worries this time!

Kind regards
Uffe
