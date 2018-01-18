From: Patrice CHOTARD <patrice.chotard@st.com>
Subject: Re: [PATCH v2 03/15] mmc: mmci: Don't pretend all variants to have
 OPENDRAIN bit
Date: Thu, 18 Jan 2018 13:24:52 +0000
Message-ID: <1fc0817f-2495-6996-4777-abc8c30c20d2@st.com>
References: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
 <1516105859-3525-4-git-send-email-patrice.chotard@st.com>
 <CAPDyKFrhBfGq0RBBdFLex+88XqrLB-Bm3rc2Q_UZCw8XB520ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFrhBfGq0RBBdFLex+88XqrLB-Bm3rc2Q_UZCw8XB520ug@mail.gmail.com>
Content-Language: en-US
Content-ID: <95FE21E4F6BC6E4898E1488CCF17389B@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf

On 01/17/2018 10:33 AM, Ulf Hansson wrote:
> [...]
> 
>>   /* Busy detection for the ST Micro variant */
>> @@ -1455,16 +1465,13 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>                                  ~MCI_ST_DATA2DIREN);
>>          }
>>
>> -       if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN) {
>> -               if (host->hw_designer != AMBA_VENDOR_ST)
>> -                       pwr |= MCI_ROD;
>> -               else {
>> -                       /*
>> -                        * The ST Micro variant use the ROD bit for something
>> -                        * else and only has OD (Open Drain).
>> -                        */
>> -                       pwr |= MCI_OD;
>> -               }
>> +       if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN &&
>> +           host->variant->opendrain) {
> 
> A few nitpicks (because I anyway had some comment on patch4):
> 
> The above can be written on one line and the brackets isn't needed.
> 
> Replace host->variant->opendrain with variant->opendrain. The same
> applies to the below change.

Ah yes, i will fix it

> 
>> +               /*
>> +                * The ST Micro variant use the ROD bit for
>> +                * something else and only has OD (Open Drain).
>> +                */
> 
> I think we can remove this comment, as this information becomes
> implicit when we start using the variant data.

Ok

Thanks

Patrice

> 
>> +               pwr |= host->variant->opendrain;
>>          }
>>
>>          /*
>> --
>> 1.9.1
>>
> 
> Kind regards
> Uffe
> 
