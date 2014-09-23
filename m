From: Behan Webster <behanw@converseincode.com>
Subject: Re: [PATCH] gpio, bcm-kona, LLVMLinux: Remove use of __initconst
Date: Tue, 23 Sep 2014 15:59:20 -0700
Message-ID: <5421FB48.1040301@converseincode.com>
References: <1411500616-12863-1-git-send-email-behanw@converseincode.com> <20140923212922.GG12270@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20140923212922.GG12270@beef>
Sender: linux-gpio-owner@vger.kernel.org
To: Matt Porter <mporter@linaro.org>
Cc: bcm@fixthebug.org, chris@printf.net, gnurou@gmail.com, linus.walleij@linaro.org, ulf.hansson@linaro.org, bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, rjui@broadcom.com
List-Id: linux-mmc@vger.kernel.org

On 09/23/14 14:29, Matt Porter wrote:
> On Tue, Sep 23, 2014 at 12:30:16PM -0700, behanw@converseincode.com wrote:
>> From: Behan Webster <behanw@converseincode.com>
>>
>> The __initconst is in the wrong place, and when moved to the correct place
>> it uncovers an error where the variable is used by non-init data structures.
>>
>> Instead merely make them const and put the const in the right spot.
>>
>> Signed-off-by: Behan Webster <behanw@converseincode.com>
>> Reviewed-by: Mark Charlebois <charlebm@gmail.com>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   drivers/gpio/gpio-bcm-kona.c      | 2 +-
>>   drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
> As mentioned on IRC, Linus, Chris, and Ulf probably would like this
> split to go into each respective tree.
Thanks Matt.

I reposted as a 2 patch series. Strictly speaking one patch is for each 
tree.

Behan

-- 
Behan Webster
behanw@converseincode.com

