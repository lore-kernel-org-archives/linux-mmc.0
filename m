From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: core: skip mmc_power_up call from start host
Date: Tue, 17 Jul 2012 16:31:32 +0530
Message-ID: <CAGxe1ZEvjFziurL4e+y6FgCNFW7ap-7yDs=z3syhZgu4Mkhnzw@mail.gmail.com>
References: <1342184235-6912-1-git-send-email-girish.shivananjappa@linaro.org>
	<CANfBPZ8dR7mzQpYKqCoqqRBwa8dCJD9JZ_tWDr+PVOMp0Ew-qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CANfBPZ8dR7mzQpYKqCoqqRBwa8dCJD9JZ_tWDr+PVOMp0Ew-qw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 17 July 2012 16:22, S, Venkatraman <svenkatr@ti.com> wrote:
> On Fri, Jul 13, 2012 at 6:27 PM, Girish K S
> <girish.shivananjappa@linaro.org> wrote:
>> The call to the mmc_power_up during the mmc_start_host breaks the card
>> detection in design-ware host controller. This patch removes the call to
>> mmc_power_up function during host start.
>>
> Please explain why. Which commit introduced it ?
dw_mmc card detection is broken by this commit
fa5501890d8974301042e0202d342a6cbe8609f4
>
>> This fix works fine with sdhci (sdhci compatilble host controller)
>> and dw_mmc (design-ware host controller). and has no side effect due to
>> this removal.
>>
> How can you be sure ? What about other hosts ?
I have tested on the available host controllers. It would be helpful
if others test it and let me know whether this change of mine causes
any problem.
