From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC 2/2] mmc: sdhci-pci: Use ACPI to get max frequency for Intel
 byt sdio host controller sub-vended by NI
Date: Tue, 15 Nov 2016 15:20:02 +0200
Message-ID: <bed36ad5-e3a0-b1bd-3772-675675d1b274@intel.com>
References: <1478635635-14953-1-git-send-email-zach.brown@ni.com>
 <1478635635-14953-3-git-send-email-zach.brown@ni.com>
 <af8a14a2-55a5-1d44-663e-53ff20408f10@intel.com>
 <20161109160827.GA6138@zach-desktop>
 <20161111194952.GC16850@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161111194952.GC16850@jcartwri.amer.corp.natinst.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>
Cc: Julia Cartwright <julia@ni.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 11/11/16 21:49, Julia Cartwright wrote:
> On Wed, Nov 09, 2016 at 10:08:29AM -0600, Zach Brown wrote:
>> On Wed, Nov 09, 2016 at 03:24:24PM +0200, Adrian Hunter wrote:
>>> On 08/11/16 22:07, Zach Brown wrote:
>>>> On NI 9037 boards the max SDIO frequency is limited by trace lengths
>>>> and other layout choices. The max SDIO frequency is stored in an ACPI
>>>> table, as MXFQ.
>>>>
>>>> The driver reads the ACPI entry MXFQ during sdio_probe_slot and sets the
>>>> f_max field of the host with it.
>>>>
>>>> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
>>>> Reviewed-by: Jaeden Amero <jaeden.amero@ni.com>
>>>> Reviewed-by: Josh Cartwright <joshc@ni.com>
>>>> Signed-off-by: Zach Brown <zach.brown@ni.com>
> [..]
>>>>  static int ni_byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
>>>>  {
>>>> +#ifdef CONFIG_ACPI
>>>> +	/* Get max freq from ACPI for NI hardware */
>>>> +	acpi_handle acpi_hdl;
>>>> +	acpi_status status;
>>>> +	struct acpi_buffer acpi_result = {
>>>> +		ACPI_ALLOCATE_BUFFER, NULL };
>>>> +	union acpi_object *acpi_buffer;
>>>> +	int max_freq;
>>>> +
>>>> +	status = acpi_get_handle(ACPI_HANDLE(&slot->chip->pdev->dev), "MXFQ",
>>>> +				 &acpi_hdl);
>>>
>>> Is "MXFQ" an object that has already been deployed or are you inventing it
>>> now?  In the latter case, did you consider device properties as an alternative?
>>>
>> "MXFQ" is an object that we have already deployed on some of our devices.
> 
> Unfortunately, the whole ACPI device properties table discussion was
> just starting at the point where we were putting the firmware together
> for these devices :(.  Had we engineered the firmware today, we would
> certainly have looked at using it.

No problem.

WRT the code, could acpi_evaluate_integer() be used instead of
acpi_get_handle()/acpi_evaluate_object()?
