From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci-s3c: let device core setup the default pin configuration
Date: Fri, 22 Mar 2013 12:33:33 -0400
Message-ID: <87y5dfo0ma.fsf@octavius.laptop.org>
References: <1362569776-13932-1-git-send-email-thomas.abraham@linaro.org>
	<CACRpkdY-RVAXxc2TqDcczhCLGDC8d401ucuCCDzRb+Ha9apr8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CACRpkdY-RVAXxc2TqDcczhCLGDC8d401ucuCCDzRb+Ha9apr8g@mail.gmail.com>
	(Linus Walleij's message of "Thu, 7 Mar 2013 09:09:58 +0100")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, ben-linux@fluff.org, jh80.chung@samsung.com, tgih.jun@samsung.com, girish.shivananjappa@linaro.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Mar 07 2013, Linus Walleij wrote:
> On Wed, Mar 6, 2013 at 12:36 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>
>> With device core now able to setup the default pin configuration,
>> the call to devm_pinctrl_get_select_default can be removed. And
>> the pin configuration code based on the deprecated Samsung specific
>> gpio bindings is also removed.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
