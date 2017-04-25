From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC 3/4] mmc: sdhci-acpi: Set MMC_CAP2_NO_SDIO_RESET if
 child has wake from S4 (hibernate)
Date: Tue, 25 Apr 2017 13:05:42 +0200
Message-ID: <CAJZ5v0irctEBjpXFLW9nuevx4L0HNigNMQv1qgCuGp7tOiE8Jg@mail.gmail.com>
References: <1492769288-7474-1-git-send-email-adrian.hunter@intel.com>
 <1492769288-7474-4-git-send-email-adrian.hunter@intel.com>
 <CAJZ5v0hcfsbfy=KhgTDvg7zj-egKODDJAF0-gqWdxuxKfyBFPQ@mail.gmail.com> <a28facd9-9d81-2be0-280b-ac4267e334d0@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <a28facd9-9d81-2be0-280b-ac4267e334d0@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 25, 2017 at 9:28 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 25/04/17 00:52, Rafael J. Wysocki wrote:
>> On Fri, Apr 21, 2017 at 12:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> SDIO reset interferes with a SDIO function driver's restore from
>>> hibernation. Set MMC_CAP2_NO_SDIO_RESET if a child node has _S4W method
>>> which indicates a capability to wake from S4 (hibernate).
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>> ---
>>>  drivers/mmc/host/sdhci-acpi.c | 17 ++++++++++++++++-
>>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>>> index c6a9a1bfaa22..e053a45db6b1 100644
>>> --- a/drivers/mmc/host/sdhci-acpi.c
>>> +++ b/drivers/mmc/host/sdhci-acpi.c
>>> @@ -374,6 +374,14 @@ static const struct sdhci_acpi_slot *sdhci_acpi_get_slot(const char *hid,
>>>         return NULL;
>>>  }
>>>
>>> +static bool sdhci_acpi_child_has_s4w(struct acpi_device *child)
>>> +{
>>> +       acpi_handle handle = child->handle;
>>> +       unsigned long long ret;
>>> +
>>> +       return ACPI_SUCCESS(acpi_evaluate_integer(handle, "_S4W", NULL, &ret));
>>
>> First off, there is acpi_has_method().
>>
>> Second, checking child->wakeup.sleep_state is a better indicator of S4
>> wakeup support.
>
> So, like this?
>
>         child->wakeup.sleep_state >= ACPI_STATE_S4
>
> That comes just from _PRW right?

It may be fixed up if the power resources in there don't match what
_PRW itself returns, but generally yes.

In any case _S4W is optional even for devices that can wake up from S4 IIRC.

Thanks,
Rafael
