From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH v4 5/8] mmc: sdhci-bcm-kona: Add basic use of clocks
Date: Fri, 24 Jan 2014 09:07:24 -0800
Message-ID: <CAAYSxhrBSv8_Z1SfB-b3iGgq218Gttny4FEgYJnLtSFhJd2UFg@mail.gmail.com>
References: <1386271244-3927-1-git-send-email-tim.kryger@linaro.org>
	<1386271244-3927-6-git-send-email-tim.kryger@linaro.org>
	<CAEPRUYrPXf7QNzput0bz_UPfytRy1eYgyOJYnH5v2v4DCEKSNA@mail.gmail.com>
	<CAAYSxhoCrveHd5Wkc7Z0qzpGr41qG6-neYSSsuHQuC7AcuJmZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAYSxhoCrveHd5Wkc7Z0qzpGr41qG6-neYSSsuHQuC7AcuJmZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Daudt <bcm@fixthebug.org>, Chris Ball <cjb@laptop.org>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Axel Lin <axel.lin@ingics.com>, Device Tree List <devicetree@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Linaro Patches List <patches@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 7, 2014 at 11:37 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
> On Sat, Dec 14, 2013 at 12:14 AM, Christian Daudt <bcm@fixthebug.org> wrote:
>> On Thu, Dec 5, 2013 at 11:20 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
>>> Enable the external clock needed by the host controller during the
>>> probe and disable it during the remove.
>>>
>>> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
>>> Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
>>> Reviewed-by: Matt Porter <matt.porter@linaro.org>
>>
>> Reviewed-by: Christian Daudt <bcm@fixthebug.org>
>>
>> Chris,
>>  Are you ok with me pulling this patch along with the rest of the
>> patchset into the bcm tree?
>>
>>  Thanks,
>>    csd
>
> Chris,
>
> Can you please provide an answer to csd?
>
> Thanks,
> Tim Kryger

Chris,

I haven't heard back so this patch has been dropped for 3.14 to allow
the remaining patches in the series to move forward.   As such, I will
be re-posting this patch for 3.15.  It is essential for the
bcm28155_ap board to transition away from fake fixed clocks to the
real clock driver.  This is because the bcm281xx clock driver does not
set the CLK_IGNORE_UNUSED flag for the SDHCI peripheral clocks and the
common clock code will shut them off in late init unless the SDHCI
driver has asked for them to be enabled.

Thanks,
Tim
