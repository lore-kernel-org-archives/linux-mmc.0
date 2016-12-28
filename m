From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / LPSS: Work around wrong sdio _ADR 0 entry on some
 byt/cht devices
Date: Wed, 28 Dec 2016 23:30:35 +0100
Message-ID: <CAJZ5v0gjcaYtskSMueAz+GjHcLZv=4A8Qz_Lf6Bn7S0CLSkgPg@mail.gmail.com>
References: <20161225102148.7706-1-hdegoede@redhat.com> <CAJZ5v0ibDwkA2Pc+nkYXS6Mq6CKT3jAnjrfCaEiCtZye5JD75A@mail.gmail.com>
 <20161228091428.GY1460@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20161228091428.GY1460@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede <hdegoede@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-mmc@vger.kernel.org, Stable <stable@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Dec 28, 2016 at 10:14 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Mon, Dec 26, 2016 at 12:25:19AM +0100, Rafael J. Wysocki wrote:
>> CC Mika and Andy.
>>
>> Plus I don't think -stable is going to take your patches directly.
>>
>> On Sun, Dec 25, 2016 at 11:21 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> > The firmware on some cherrytrail devices wrongly adds _ADR 0 to their
>> > entry describing the 80860F14 uid "2" sd-controller.
>> >
>> > I believe the firmware writers intended this as a sdio function address,
>> > but it is in the wrong place for this, so it gets interpreted as a pci
>> > address, causing the node describing the sd-controller used for the
>> > sdio-wifi to get seen as a firmware_node for the pci host bridge, rather
>> > then being stand-alone device.
>> >
>> > This commit adds a byt_sdio_setup function which detects this scenario
>> > and removes the wrong firmware_node link from the pci host bridge, which
>> > fixes acpi_create_platform_device returning NULL, leading to non-working
>> > sdio-wifi.
>> >
>> > BugLink: https://github.com/hadess/rtl8723bs/issues/80
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> > ---
>> >  drivers/acpi/acpi_lpss.c | 30 ++++++++++++++++++++++++++++++
>> >  1 file changed, 30 insertions(+)
>> >
>> > diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
>> > index 373657f..df9cc66 100644
>> > --- a/drivers/acpi/acpi_lpss.c
>> > +++ b/drivers/acpi/acpi_lpss.c
>> > @@ -84,6 +84,7 @@ static const struct lpss_device_desc lpss_dma_desc = {
>> >  };
>> >
>> >  struct lpss_private_data {
>> > +       struct acpi_device *adev;
>> >         void __iomem *mmio_base;
>> >         resource_size_t mmio_size;
>> >         unsigned int fixed_clk_rate;
>> > @@ -154,6 +155,33 @@ static void byt_i2c_setup(struct lpss_private_data *pdata)
>> >         writel(0, pdata->mmio_base + LPSS_I2C_ENABLE);
>> >  }
>> >
>> > +static void byt_sdio_setup(struct lpss_private_data *pdata)
>> > +{
>> > +       unsigned long long adr;
>> > +       acpi_status status;
>> > +       struct device *dev;
>> > +
>> > +       /*
>> > +        * Some firmware has a broken _ADR 0 enter for the 80860F14:2
>> > +        * device, which causes it to get seen as the firmware_node
>> > +        * for the pci host bridge, rather then a stand alone device.
>> > +        *
>> > +        * Check if this is the case, and if it is remove the link.
>> > +        */
>> > +       if (strcmp(acpi_device_uid(pdata->adev), "2") != 0)
>> > +               return;
>> > +
>> > +       status = acpi_evaluate_integer(pdata->adev->handle, "_ADR", NULL, &adr);
>> > +       if (ACPI_FAILURE(status) || adr != 0)
>> > +               return;
>> > +
>> > +       dev = acpi_get_first_physical_node(pdata->adev);
>> > +       if (!dev)
>> > +               return;
>> > +
>> > +       acpi_unbind_one(dev);
>> > +}
>
> IIRC the _ADR 0 problem is not only limited to SDIO devices. I think we
> should just fix the match heuristics in acpi_find_child_device() to
> cover all other devices as well.
>
> Something like below might do the job.
>
> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> index 5ea5dc219f56..7cfd48f55b6f 100644
> --- a/drivers/acpi/glue.c
> +++ b/drivers/acpi/glue.c
> @@ -85,7 +85,7 @@ static struct acpi_bus_type *acpi_get_bus_type(struct device *dev)
>
>  static int find_child_checks(struct acpi_device *adev, bool check_children)
>  {
> -       bool sta_present = true;
> +       bool hid_present, sta_present = true;
>         unsigned long long sta;
>         acpi_status status;
>
> @@ -98,7 +98,22 @@ static int find_child_checks(struct acpi_device *adev, bool check_children)
>         if (check_children && list_empty(&adev->children))
>                 return -ENODEV;
>
> -       return sta_present ? FIND_CHILD_MAX_SCORE : FIND_CHILD_MIN_SCORE;
> +       /*
> +        * If there is a _HID or _CID present on a bus that is supposed to
> +        * be matched using _ADR, we prioritize those devices without ID
> +        * higher.
> +        *
> +        * This is because there are many BIOSes out there having ACPI
> +        * enumerated devices and the _ADR is set to 0. This will match the
> +        * root PCI bridge to the first found device with _ADR 0 which is
> +        * not always the right device.
> +        */
> +       hid_present = !list_empty(&adev->pnp.ids);
> +
> +       if (sta_present)
> +               return hid_present ? FIND_CHILD_MIN_SCORE : FIND_CHILD_MAX_SCORE;
> +
> +       return FIND_CHILD_MIN_SCORE;
>  }
>
>  struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
>

I'd rather only change the return statement, like this:

return sta_present && list_empty(&adev->pnp.ids) ?
FIND_CHILD_MAX_SCORE : FIND_CHILD_MIN_SCORE;

I'll send a patch tomorrow unless there's something wrong with this.

BTW, the comment is not correct too, because the host bridge has a
_HID.  What is matched against _ADR(0) is the first function on bus 0
IIRC.

Thanks,
Rafael
