From: =?gb2312?B?zfXsvw==?= <wei_wang@realsil.com.cn>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHYyIDAvMl0gQWRkIG1vZHVsZXMgdG8gc3VwcG9ydCBy?==?gb2312?B?ZWFsdGVrIFBDSUUgY2FyZCByZWFkZXI=?=
Date: Tue, 14 Aug 2012 23:22:38 +0800
Message-ID: <637A8844983F7F4092120E33EA3F28CD31E74BE133@RSEX1.realsil.com.cn>
References: <cover.1344939464.git.wei_wang@realsil.com.cn>,
 <20120814150550.GA4091@x1.osrc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <20120814150550.GA4091@x1.osrc.amd.com>
Content-Language: zh-CN
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: Borislav Petkov <bp@alien8.de>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "cjb@laptop.org" <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hi Boris:

Can you tell me the detailed information about your pc and the SD card? Do you have ever tried to use another SD card? 
I have tested all of the SD cards that we have in our company, and everything runs smoothly.  Maybe it is compatibilty issue and we have to debug it specifically.

Please help to check the VID:PID of the card reader using lspci, and I will send you our SCSI driver for this reader to test the card.

Thank you!
BR,
wwang

________________________________________

Yeah, this thing still has issues though.

When I slide in an SD card and do

$ mkfs.ext3 /dev/mmcblk0p1

after having created the partition with fdisk, we run out of DMA space and the
hung-tasks detector triggers:


--
Regards/Gruss,
Boris.
