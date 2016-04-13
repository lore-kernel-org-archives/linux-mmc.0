From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] qcom: sdhci-msm: enable the DLL clock
Date: Wed, 13 Apr 2016 13:40:12 +0200
Message-ID: <CAPDyKFp4Njdb7g6p_yM7E4MSqYiHGA4O1rB3wLy8X_F3q5j5nA@mail.gmail.com>
References: <1459842403-4052-1-git-send-email-ssambang@codeaurora.org>
	<CAPDyKFr7dWOxb_o7b9AyEWYSROtjdktPXwKexAjBGaFw5M-Fig@mail.gmail.com>
	<20160411221126.GD14441@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160411221126.GD14441@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Sreedhar Sambangi <ssambang@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, qca-upstream.external@qca.qualcomm.com, Ivan Ivanov <ivan.ivanov@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On 12 April 2016 at 00:11, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 04/11, Ulf Hansson wrote:
>> + Adrian
>>
>> On 5 April 2016 at 09:46, Sreedhar Sambangi <ssambang@codeaurora.org> wrote:
>> > The DLL clock has to be enabled until the correct
>> > clock frequency is delivered to DLL
>> > '1'(default) - DLL clock is disabled
>> > '0' - dll clock has legacly clock enable.
>> >
>> > Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
>> > Signed-off-by: Sreedhar Sambangi <ssambang@codeaurora.org>
>>
>> Adrian Hunter is the maintainer for sdhci, next time make sure to post to him.
>>
>> As this seems like fairly trivial change I decided to pick it up
>> anyway. So applied for next!
>>
>> Note, that I changed the prefix of the commit message header to "mmc".
>>
>
> I'm not sure this patch is actually right. In the downstream
> sources we do quite a few more reads and writes if we need to
> poke this second DLL configuration register. Furthermore, on
> msm8974 and apq8084 this register doesn't even exist so writing
> to it may cause problems if it isn't write ignored (I haven't
> checked).
>
> I think we should follow the downstream kernel design instead.
> Namely, reading the major/minor version registers to figure out
> if we should be touching this register in the first place, and
> then adding a clock property to the DT binding for the XO source
> so we can determine the XO frequency. It seems that we need this
> frequency to figure out how to program the second DLL
> configuration register appropriately.

Stephen,

Thanks for reviewing. I have dropped this patch for now.

Kind regards
Uffe
