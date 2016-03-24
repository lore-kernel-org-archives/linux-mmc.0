From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 2/2] regulator: core: Ensure we are at least in bounds for
 our constraints
Date: Thu, 24 Mar 2016 15:11:43 +0900
Message-ID: <CAJKOXPd5h0Cq++OxdiXytNJH94PN4Kh_wM3M=p3JdU1m_qyFTA@mail.gmail.com>
References: <1458587912-32665-1-git-send-email-broonie@kernel.org>
	<1458587912-32665-2-git-send-email-broonie@kernel.org>
	<56F0624C.8010004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36563 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbcCXGLp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2016 02:11:45 -0400
In-Reply-To: <56F0624C.8010004@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On Tue, Mar 22, 2016 at 6:06 AM, Ivaylo Dimitrov
<ivo.g.dimitrov.75@gmail.com> wrote:
> Hi,
>
> On 21.03.2016 21:18, Mark Brown wrote:
>>
>> Currently we only attempt to set the voltage during constraints
>> application if an exact voltage is specified.  Extend this so that if
>> the currently set voltage for the regualtor is outside the bounds set in
>
>
> regulator
>
>> constraints we will move the voltage to the nearest constraint, raising
>> to the minimum or lowering to the maximum as needed.  This ensures that
>> drivers can probe without the hardware being driven out of spec.
>>
>> Reported-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> ---
>>
>> Untested so far, will give it a spin later/tomorrow.
>>
>>   drivers/regulator/core.c | 32 +++++++++++++++++++++++++-------
>>   1 file changed, 25 insertions(+), 7 deletions(-)
>>
>
> Patch 1 does not apply cleanly on 4.5-rc5, so I applied it by hand, however,
> you may add:
>
> Tested-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>


Cc: Ulf, mmc

I bisected today's next MMC/SD card failure to this patch. Plugging a
SD card on Odroid XU3/XU4 (Exynos5422) causes:
[   11.759954] mmc1: card never left busy state
[   11.762795] mmc1: error -110 whilst initialising SD card

Full log (for booting from SD but it happens also when plugging the
card to the board booted from eMMC):
http://www.krzk.eu/builders/boot-odroid-xu3-multi_v7/builds/538/steps/Boot%20odroid/logs/serial

Bisect log:
# bad: [6f30d29c603cd444d76fadb393ea412e843ff095] Add linux-next
specific files for 20160324
# good: [b562e44f507e863c6792946e4e1b1449fbbac85d] Linux 4.5
git bisect start 'HEAD' 'v4.5'
# good: [35fe688abfcfeadf678664ae2e04815bb416de5a] arm-soc: document merges
git bisect good 35fe688abfcfeadf678664ae2e04815bb416de5a
# good: [2c856e14dad8cb1b085ae1f30c5e125c6d46019b] Merge tag
'arm64-perf' of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect good 2c856e14dad8cb1b085ae1f30c5e125c6d46019b
# good: [b8ba4526832fcccba7f46e55ce9a8b79902bdcec] Merge tag
'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dledford/rdma
git bisect good b8ba4526832fcccba7f46e55ce9a8b79902bdcec
# good: [c8c840c7f5d4ae6ae6e1a029a1c8797df3e8756b] Merge
remote-tracking branch 'ubifs/linux-next'
git bisect good c8c840c7f5d4ae6ae6e1a029a1c8797df3e8756b
# good: [974966a719fe6cd162990189c77986713b45dc83] Merge
remote-tracking branch 'input/next'
git bisect good 974966a719fe6cd162990189c77986713b45dc83
# bad: [49e1bab1b81d3a90a05d246f79e31938fe04e488] Merge
remote-tracking branch 'usb-chipidea-next/ci-for-usb-next'
git bisect bad 49e1bab1b81d3a90a05d246f79e31938fe04e488
# bad: [fad6ea2fe037a54db8eee8d6e74936e66489e52c] Merge
remote-tracking branch 'tip/auto-latest'
git bisect bad fad6ea2fe037a54db8eee8d6e74936e66489e52c
# bad: [dfb94c1d845d21740c4eb54e5d87f650d4362e9c] Merge
remote-tracking branch 'spi/for-next'
git bisect bad dfb94c1d845d21740c4eb54e5d87f650d4362e9c
# good: [0480adb1395bb6575d2e4174d0c2ed4c4df0275f] Merge branch
'master' into next
git bisect good 0480adb1395bb6575d2e4174d0c2ed4c4df0275f
# good: [c7faa32adbeacc97a2b2cf209c59161eb5efbc30] Merge
remote-tracking branch 'md/for-next'
git bisect good c7faa32adbeacc97a2b2cf209c59161eb5efbc30
# good: [78b5a17c35bd3b301bac25a72a1988b7537e5dc6] Merge
remote-tracking branches 'spi/fix/omap2' and 'spi/fix/rockchip' into
spi-linus
git bisect good 78b5a17c35bd3b301bac25a72a1988b7537e5dc6
# bad: [7e89db5db77fd4b2e49982c6f2ee39f4306c66a4] Merge
remote-tracking branches 'regulator/fix/constrain' and
'regulator/fix/gpio' into regulator-linus
git bisect bad 7e89db5db77fd4b2e49982c6f2ee39f4306c66a4
# bad: [bae4fdc88d7f7dda1bfb3dd282978c617dbf16e3] regulator: core:
Ensure we are at least in bounds for our constraints
git bisect bad bae4fdc88d7f7dda1bfb3dd282978c617dbf16e3
# good: [895fe2321efaf62023fdd8239d1846394df68570] regulator: core:
Always flag voltage constraints as appliable
git bisect good 895fe2321efaf62023fdd8239d1846394df68570
# first bad commit: [bae4fdc88d7f7dda1bfb3dd282978c617dbf16e3]
regulator: core: Ensure we are at least in bounds for our constraints

Best regards,
Krzysztof
