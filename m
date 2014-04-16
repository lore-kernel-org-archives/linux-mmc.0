From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 0/4] Add modules for realtek USB card reader
Date: Wed, 16 Apr 2014 09:27:48 +0200
Message-ID: <CAPDyKFpaWT0JqwkrYzRZN4g5B5k0NB8hq0BY5yzN-T0pxX55WA@mail.gmail.com>
References: <1397199203-2235-1-git-send-email-rogerable@realtek.com>
 <1397201514.1589.0.camel@linux-fkkt.site>
 <20140411102846.GB9801@lee--X1>
 <1397212602.4632.2.camel@linux-fkkt.site>
 <534DF6B1.30609@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <534DF6B1.30609@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Roger <rogerable@realtek.com>
Cc: Oliver Neukum <oneukum@suse.de>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>, Andrew Morton <akpm@linux-foundation.org>, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On 16 April 2014 05:19, Roger <rogerable@realtek.com> wrote:
> On 04/11/2014 06:36 PM, Oliver Neukum wrote:
>>
>> On Fri, 2014-04-11 at 11:28 +0100, Lee Jones wrote:
>>>>>
>>>>> From: Roger Tseng <rogerable@realtek.com>
>>>>>
>>>>> This patchset adds modules to support Realtek USB vendor specific class
>>>>> flash
>>>>> card reader: one base module in MFD subsystem and two host modules in
>>>>> both mmc
>>>>> and memstick subsystems. The architecture is similar to rtsx_pci.
>>>>>
>>>>> This work is done primarily to replace the staging driver:
>>>>> staging/rts5139,
>>>>> which doesn't utilize mmc nor memstick subsystems. Once the patchset or
>>>>> its
>>>>> revision is applied, we may need Greg's help to remove the staging one.
>>>>
>>>>
>>>> Looks good to me.
>>>
>>>
>>> Is that an Ack?
>>
>> Acked-by: Oliver <oneukum@suse.de>
>>
>>         Sorry
>>                 Oliver
>>
> Lee,
>
> Would you apply all of these patches?

I have sent a pull request to Chris, containing the patch with the new
mmc driver. The rest I am fine with if Lee can take though the mfd
tree.

Kind regards
Ulf Hansson

>
>
> Best regards,
> Roger Tseng
