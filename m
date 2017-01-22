From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v3 01/15] ARM: pxa: Don't rely on public mmc header to
 include leds.h
Date: Sun, 22 Jan 2017 11:25:26 +0100
Message-ID: <87y3y3crxl.fsf@belgarion.home>
References: <1484313256-25993-1-git-send-email-ulf.hansson@linaro.org>
 <1484313256-25993-2-git-send-email-ulf.hansson@linaro.org>
 <87efzydusi.fsf@belgarion.home>
 <CAPDyKFo=tUu9D5zZnUME_+HFBPEnnjy2taTdFLO9H6jSSgKc5A@mail.gmail.com>
 <87a8aleda2.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87a8aleda2.fsf@belgarion.home> (Robert Jarzmik's message of
 "Fri, 20 Jan 2017 20:34:29 +0100")
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
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-mmc@vger.kernel.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> On 20 January 2017 at 09:01, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>> So I was wondering how you made the choice of which files you add the include to
>>> and which you don't touch ?
>>
>> By building the pxa_defconfig, see what errors it reports and then fix them.
>>
>> Isn't pxa_defconfig building all the variants?
> Euh actually it should, but it's not.

And actually thanks to a suggestion from Russell to improve my search line, I
came up with the command line bellow, and perhaps you could fix the others with
one command line and respin the patch ?

Here it is :

for f in $(grep -l _led arch/arm/mach-pxa/*.c | xargs grep -L linux/leds.h); do
sed -i '0,/^#include <linux\/[l-m].*>$/{s/\(#include <linux\/[l-m].*\)/#include
<linux\/leds.h>\n\1/}' $f; done

Cheers.

-- 
Robert
