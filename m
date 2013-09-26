From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: remove dead function mmc_try_claim_host
Date: Wed, 25 Sep 2013 21:25:23 -0400
Message-ID: <87txh84bng.fsf@octavius.laptop.org>
References: <1379640096-32383-1-git-send-email-grundler@chromium.org>
	<CAPDyKFrLpVGp4qmObJ1w2pufDTPQ0ssLRxFpRYHUtMq9Vu9KMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrLpVGp4qmObJ1w2pufDTPQ0ssLRxFpRYHUtMq9Vu9KMA@mail.gmail.com> (Ulf
	Hansson's message of "Fri, 20 Sep 2013 09:35:09 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Grant Grundler <grundler@chromium.org>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, Sep 20 2013, Ulf Hansson wrote:
> On 20 September 2013 03:21, Grant Grundler <grundler@chromium.org> wrote:
>> cscsope says there are no callers for mmc_try_claim_host in the kernel.
>> No reason to keep it.
>>
>> Signed-off-by: Grant Grundler <grundler@chromium.org>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks, pushed to mmc-next for 3.13 with Ulf's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
