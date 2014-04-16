From: Roger <rogerable@realtek.com>
Subject: Re: [PATCH v7 0/4] Add modules for realtek USB card reader
Date: Wed, 16 Apr 2014 11:19:13 +0800
Message-ID: <534DF6B1.30609@realtek.com>
References: <1397199203-2235-1-git-send-email-rogerable@realtek.com>	
 <1397201514.1589.0.camel@linux-fkkt.site> <20140411102846.GB9801@lee--X1>
 <1397212602.4632.2.camel@linux-fkkt.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <1397212602.4632.2.camel@linux-fkkt.site>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Oliver Neukum <oneukum@suse.de>, Lee Jones <lee.jones@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Andrew Morton <akpm@linux-foundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On 04/11/2014 06:36 PM, Oliver Neukum wrote:
> On Fri, 2014-04-11 at 11:28 +0100, Lee Jones wrote:
>>>> From: Roger Tseng <rogerable@realtek.com>
>>>>
>>>> This patchset adds modules to support Realtek USB vendor specific class flash
>>>> card reader: one base module in MFD subsystem and two host modules in both mmc
>>>> and memstick subsystems. The architecture is similar to rtsx_pci.
>>>>
>>>> This work is done primarily to replace the staging driver: staging/rts5139,
>>>> which doesn't utilize mmc nor memstick subsystems. Once the patchset or its
>>>> revision is applied, we may need Greg's help to remove the staging one.
>>>
>>> Looks good to me.
>>
>> Is that an Ack?
> Acked-by: Oliver <oneukum@suse.de>
>
> 	Sorry
> 		Oliver
>
Lee,

Would you apply all of these patches?


Best regards,
Roger Tseng
