From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-spear: Initialize sdhci clk to 50 MHz
Date: Mon, 26 Nov 2012 20:40:07 +0530
Message-ID: <CAKohpomnN3eLUTU2zoHP-8G_YfzKokXx8qB92_6dqTnTW5WZAg@mail.gmail.com>
References: <fd576f198e6f3dc4031bb905247ed9c0a0b66a20.1352387305.git.viresh.kumar@linaro.org>
	<87obik9zaq.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87obik9zaq.fsf@octavius.laptop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Vipul Kumar Samar <vipulkumar.samar@st.com>
List-Id: linux-mmc@vger.kernel.org

On 26 November 2012 20:39, Chris Ball <cjb@laptop.org> wrote:
> On Thu, Nov 08 2012, Viresh Kumar wrote:
>> +     ret = clk_set_rate(sdhci->clk, 50000000);
>> +     if (ret)
>> +             dev_dbg(&pdev->dev, "Error setting desired clk, clk=%lu\n",
>> +                             clk_get_rate(sdhci->clk));
>> +
>>       if (np) {
>>               sdhci->data = sdhci_probe_config_dt(pdev);
>>               if (IS_ERR(sdhci->data)) {
>
> Can I change this to a dev_err()?  No-one's going to see a dev_dbg().

Yes and thanks :)

--
viresh
