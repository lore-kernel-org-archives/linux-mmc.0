From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/3] mmc: dt: usdhi6rol0: add optional pinctrl binding
Date: Tue, 26 Apr 2016 08:19:52 -0500
Message-ID: <CAL_JsqLxVDoOma+CfvoxSyDK5gybFWX3cSWBH2BWiyaAC85+gw@mail.gmail.com>
References: <cover.1461246772.git.larper@axis.com> <a96281244b55d55e36b72a40cd061d7ffd70b88e.1461246772.git.larper@axis.com>
 <20160422202733.GA11270@rob-hp-laptop> <571F5DB4.7090303@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37731 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750835AbcDZNUQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2016 09:20:16 -0400
In-Reply-To: <571F5DB4.7090303@axis.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars Persson <lars.persson@axis.com>
Cc: Lars Persson <larper@axis.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On Tue, Apr 26, 2016 at 7:23 AM, Lars Persson <lars.persson@axis.com> wrote:
>
>
> On 04/22/2016 10:27 PM, Rob Herring wrote:
>>
>> On Thu, Apr 21, 2016 at 03:55:42PM +0200, Lars Persson wrote:
>>>
>>> Add a pinctrl binding to specify different pin settings for high speed
>>> modes and UHS modes.
>>>
>>> Signed-off-by: Lars Persson <larper@axis.com>
>>> ---
>>>   Documentation/devicetree/bindings/mmc/usdhi6rol0.txt | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
>>> b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
>>> index 8babdaa..6d1b797 100644
>>> --- a/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/usdhi6rol0.txt
>>> @@ -12,6 +12,12 @@ Optional properties:
>>>
>>>   - vmmc-supply:        a phandle of a regulator, supplying Vcc to the
>>> card
>>>   - vqmmc-supply:       a phandle of a regulator, supplying VccQ to the
>>> card
>>> +- pinctrl-names: Can contain a "default" entry and a "state_uhs"
>>
>>
>> Don't use underscores. Just "uhs" should be sufficient, right?
>
>
> I do not object to this, but for consistency it seems better with state_uhs
> that existing bindings use.

Okay. Consistency is better.

Rob
