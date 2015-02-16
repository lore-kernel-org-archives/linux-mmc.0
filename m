From: Philip Rakity <prakity@nvidia.com>
Subject: Re: mmc: Driver Strength Device Property
Date: Mon, 16 Feb 2015 17:47:17 +0000
Message-ID: <C3F8DC5C-744F-44F1-9B14-AA9CDE13AE31@nvidia.com>
References: <54E1FDF2.3050104@intel.com> <54E22B52.1020401@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54E22B52.1020401@broadcom.com>
Content-Language: en-US
Content-ID: <1B254A6B54625C4EA789E52F274CBAD2@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arend van Spriel <arend@broadcom.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "rafael.j.wysocki@intel.com >> Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "mika.westerberg@intel.com" <mika.westerberg@intel.com>, "dvhart@linux.intel.com" <dvhart@linux.intel.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "chris@printf.net" <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Alex Lemberg <alex.lemberg@sandisk.com>, "Yuliy.Izrailov@sandisk.com" <Yuliy.Izrailov@sandisk.com>, Alex Courbot <acourbot@nvidia.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "Markus.Niebel@tq-group.com" <Markus.Niebel@tq-group.com>
List-Id: linux-mmc@vger.kernel.org


On Feb 16, 2015, at 5:39 PM, Arend van Spriel <arend@broadcom.com> wrote:

> On 02/16/15 15:25, Adrian Hunter wrote:
>> I am in the process of adding an ACPI Device Property to specify
>> the driver strength (aka drive strength, driver type) for use
>> with eMMC/SD/SDIO cards, however the ACPI Specification Workgroup
>> requires that Device Properties be sufficiently generic. This
>> raises several questions as to what is sufficiently generic. That
>> is covered in a Questions section below and is followed by a draft
>> ACPI Device Property Definition. Any comments would be greatly
>> appreciated.
>> 
>> First some background:
>> 
>> What are ACPI Device Properties and how do they relate to Device Tree
>> ---------------------------------------------------------------------
>> 
>> ACPI Device Properties are key / value pairs that can be recorded
>> in the ACPI DSDT using a _DSD object with a specific UUID. Refer:
>> 	The ACPI specification and
>> 	http://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
>> 	http://www.uefi.org/sites/default/files/resources/web-page-v2.pdf
>> 
>> Linux provides a common API to read ACPI Device Properties and
>> Device Tree properties. Refer:
>> 	https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/base/property.c
>> 	http://marc.info/?l=linux-kernel&m=141354745011569&w=4
>> 
>> Obviously, the common API only works when the same property name
>> is not defined differently for the same device or class
>> of devices.
>> 
>> What is Driver Strength
>> -----------------------
>> 
>> Both the JEDEC eMMC Specification and the SD Association Physical
>> Layer Specification define Driver Strength. The specifications
>> also use the terms Drive Strength and Driver Type for the same
>> thing. While the specifications deal with cards, the Host
>> Controller can also have a Driver Strength value, for example as
>> specified in the SD Host Controller Specification.
>> 
>> For eMMC, Driver Strength is an optional setting for the HS200 and
>> HS400 transfer modes.
>> 
>> Currently JEDEC defines:
>> 
>> 	Value		Nominal Impedance	Approx.	capability
>> 						relative to type 0
>> 
>> 	0		50 ohm			x1
>> 	1		33 ohm			x1.5
>> 	2		66 ohm			x0.75
>> 	3		100 ohm			x0.5
>> 	4		40 ohm			x1.2
>> 
>> For SD/SDIO, Driver Strength is an optional setting for the
>> UHS-I transfer modes.
>> 
>> The SD Association defines:
>> 
>> Driver	Value		Nominal Impedance	Approx.	capability
>> Type						relative to type 0
>> 
>> A	1		33 ohm			x1.5
>> B	0		50 ohm			x1
>> C	2		66 ohm			x0.75
>> D	3		100 ohm			x0.5
>> 
>> So the values are the same with the exception that eMMCs have the
>> additional value 4 (40 ohm). It is assumed that the values will
>> anyway not conflict because eMMC is not removable.
>> 
>> The specifications state that support for Driver Strength 0
>> (Driver Type B) is both mandatory and the default value.
>> In addition, cards supply a mask of supported Driver Strength
>> values. Therefore the Driver Strength value is validated against
>> the supported values.
>> 
>> Questions
>> ---------
>> 
>> Question 1. Should there be separate Driver Strength values for
>> cards and host controllers?
>> 
>> There is no indication from the specifications that cards and
>> host controllers need have the same value for Driver Strength.
>> That suggests that separate properties for the card and host
>> controller should be provided for.
>> 
>> Originally, I was just proposing "driver-strength" for the
>> Driver Strength of the card, but now will separate this into
>> "card-driver-strength" and "host-driver-strength".
> 
> Hi Adrian,
> 
> I am not sure if it makes sense to have a 'card-driver-strength' specification for the host controller. I have been under the impression that the proper value for this is strongly depending on the card used in the slot. For this reason and the fact that it is programmed in our device we added brcm,drive-strength property in our device-tree bindings [1].
> 
> Regards,
> Arend
> 
> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt

Adrian, Arend,

My experience is that the value also depends very much on the board design as well as the eMMC/sdio chip being used.  eMMC chips have
some variation.  A DT entry does make sense for eMMC and other wired in devices but in this case the value is a property of the hardware
and "burnt in" as a property of the board design.

regards,

Philip

>> Question 2. To what devices should the Driver Strength properties
>> bind?
>> 
>> A Driver Strength property for the host controller obviously
>> binds to the host controller device.
>> 
>> Additionally it can be assumed that Driver Strength is a property
>> of the board (e.g. a stronger Driver Strength needed because the
>> eMMC is located further from the host controller), consequently
>> even the Driver Strength property for the card should bind against
>> the host controller.
>> 
>> Question 3. Should there be separate Driver Strength values for
>> different transfer modes?
>> 
>> Different transfer modes can have different timing requirements
>> which implies that there can be different Driver Strength values
>> for each transfer mode. To support that, there would need to be
>> either separate properties for each mode, or more simply two
>> properties that list associated transfer modes and Driver
>> Strengths. Transfer modes are not codified but have standard
>> names that could be used e.g. "HS400" or "SDR104"
>> 
>> Question 4. Should there be separate Driver Strength values for
>> different frequencies?
>> 
>> To be generic, another property would be needed to specify the
>> frequency from which the Driver Strength is needed.
>> 
>> Question 5. Should there be separate Driver Strength values for
>> different voltages?
>> 
>> UHS-I modes all have the same signal voltage (1.8V) however HS200
>> and HS400 support both 1.2V and 1.8V.
>> That could be handled by having having different mode strings for
>> the variants. i.e. "HS200", "HS200-1.2V", "HS200-1.8V", "HS400",
>> "HS400-1.2V", 'HS400-1.8V"
>> 
>> Question 6. Should there be separate Driver Strength values for
>> different slots?
>> 
>> In order to support multiple slots, the slot number can be appended
>> to the property names to define a separate set of properties for
>> each slot.
>> 
>> Question 7. Should the possibility of multiple cards in the same
>> slot be supported?
>> 
>> Linux does not support having multiple cards in the same slot.
>> Presumably, the Driver Strength for each card would bind to the
>> card device, which would require defining how card devices are
>> identified. That might be possible, but it is out of scope.
>> 
>> ACPI Device Property definitions:
>> ---------------------------------
>> 
>> Based on my answers to the questions, the ACPI Device Property
>> definitions would look like this:
>> 
>> The following Device Properties are for general use with
>> any eMMC, SD card, or SDIO host controller.
>> 
>> ---------------------------------------------------------------------------
>> Property:	card-driver-strength-0
>> Value:		Package of Integers
>> Description:
>>      If present, defines a list of the driver strength values
>>      for a card in slot 0. The driver strength is an optional
>>      setting defined by the JEDEC eMMC specification or the
>>      SD Association Physical Layer specification, for use with
>>      HS200/HS400 or UHS-I transfer modes. In absence of this
>>      property, the default value of 0 is used.
>> 
>>      Example values:
>> 
>> 	Value		Nominal Impedance	Approx.	capability
>> 						relative to type 0
>> 
>> 	0		50 ohm			x1
>> 	1		33 ohm			x1.5
>> 	2		66 ohm			x0.75
>> 	3		100 ohm			x0.5
>> 	4		40 ohm			x1.2
>> 
>>      The driver strength values associate one-to-one
>>      with the values of properties card-driver-strength-mode-0 and
>>      card-driver-strength-freq-0. Transfer modes or frequencies not
>>      specified will have the default driver strength of 0.
>>      Neither card-driver-strength-mode-0 nor card-driver-strength-freq-0
>>      need be present in which case there must be only one driver
>>      strength value which will be used with all relevant transfer
>>      modes and frequencies.
>> 
>>      For host controllers that define multiple slots,
>>      the value applies to the first slot (slot 0), and
>>      each subsequent slot requires another property of
>>      the form card-driver-strength-n when n is the slot
>>      number (e.g. for the 2nd slot card-driver-strength-1)
>> 
>> Example for a single slot host controller with a single value:
>>      Package (2) { "card-driver-strength-0",
>>                    Package (1) { 1 }
>>      }
>> 
>> Example for a multiple slot host controller with 3 slots all with
>> a single value:
>>      Package (2) { "card-driver-strength-0",
>>                    Package (1) { 1 }
>>      }
>>      Package (2) { "card-driver-strength-1",
>>                    Package (1) { 3 }
>>      }
>>      Package (2) { "card-driver-strength-2",
>>                    Package (1) { 0 }
>>      }
>> 
>> ---------------------------------------------------------------------------
>> Property:	card-driver-strength-mode-0
>> Value:		Package of Strings
>> Description:
>>     If present, defines the transfer modes to which the values
>>     of card-driver-strength-0 apply. The transfer modes are
>>     identified by name and where necessary voltage. i.e.
>> 
>>     eMMC transfer modes:
>> 
>>         "HS200",
>>         "HS200-1.2V",
>>         "HS200-1.8V",
>>         "HS400",
>>         "HS400-1.2V",
>>         "HS400-1.8V",
>> 
>>     UHS-I transfer modes:
>> 
>>         "SDR12",
>>         "SDR25",
>>         "SDR50",
>>         "SDR104",
>>         "DDR50",
>> 
>>     The empty string ("") can be used to mean all modes not
>>     otherwise specified. The names of new modes should be
>>     inferred from the relevant specifications.
>> 
>> Example for a single slot host controller with a single value for
>> HS400 mode:
>>      Package (2) { "card-driver-strength-0",
>>                    Package (1) { 1 }
>>      }
>>      Package (2) { "card-driver-strength-mode-0",
>>                    Package (1) { "HS400" }
>>      }
>> 
>> ---------------------------------------------------------------------------
>> Property:	card-driver-strength-freq-0
>> Value:		Package of Integers
>> Description:
>>     If present, defines the starting frequencies to which the values
>>     of card-driver-strength-0 apply. The frequency is in Hz.
>> 
>> Example for a single slot host controller with Driver Strength 4
>> for HS400 starting at 50MHz changing to Driver Strength 1 at 100MHz.
>>      Package (2) { "card-driver-strength-0",
>>                    Package (1) { 4, 1 }
>>      }
>>      Package (2) { "card-driver-strength-mode-0",
>>                    Package (1) { "HS400", "HS400" }
>>      }
>>      Package (2) { "card-driver-strength-freq-0",
>>                    Package (1) { 50000000, 100000000 }
>>      }
>> 
>> ---------------------------------------------------------------------------
>> Property:	host-driver-strength-0
>> Value:		Package of Integers
>> Description:
>>     Same as card-driver-strength-0 but values are used for the
>>     host controller not the card.
>> 
>> ---------------------------------------------------------------------------
>> Property:	host-driver-strength-mode-0
>> Value:		Package of Strings
>> Description:
>>     Same as card-driver-strength-mode-0 but values are used for the
>>     host controller not the card.
>> 
>> ---------------------------------------------------------------------------
>> Property:	host-driver-strength-freq-0
>> Value:		Package of Integers
>>     Same as card-driver-strength-freq-0 but values are used for the
>>     host controller not the card.
>> 
>> 
>> 
>> Regards
>> Adrian
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
> 
