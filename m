From: Rajat Jain <rajatja@google.com>
Subject: sdhci driver card-detect is broken because gpiolib can't fallback to _CRS?
Date: Tue, 25 Sep 2018 13:54:57 -0700
Message-ID: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Rajat Jain <rajatxjain@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

With commit f10e4bf6632b5b ("gpio: acpi: Even more tighten up ACPI
GPIO lookups"), the gpio lookups were tightened up such that _CRS
method will *only* be tried for lookup, if the ACPI node for the
device does not contain any _DSD properties, AND con_id=NULL:

bool acpi_can_fallback_to_crs(struct acpi_device *adev, const char *con_id)
{
        /* Never allow fallback if the device has properties */
        if (adev->data.properties || adev->driver_gpios)
                return false;

        return con_id == NULL;
}

>From the commit log of the said commit, the following types of cases
were identified:

    Case 1: (I think this represents the modern BIOS, because this is
what we want everyone to use i.e. we want to be able to lookup using
_DSD preferably:)

        Device (DEVX)
        {
            ...
            Name (_CRS, ResourceTemplate ()
            {
                GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
                        "\\_SB.GPO0", 0, ResourceConsumer) {15}
            })
            Name (_DSD, Package ()
            {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package ()
                {
                    Package () {"some-gpios", Package() {^DEVX, 0, 0, 0 }},
                }
            })
        }

    Case 2: (I think this represents the Legacy BIOS, because this is
what has been in use historically, i.e. need to lookup via the _CRS):

        Device (DEVX)
        {
            ...
            Name (_CRS, ResourceTemplate ()
            {
                GpioIo (Exclusive, PullUp, 0, 0, IoRestrictionInputOnly,
                        "\\_SB.GPO0", 0, ResourceConsumer) {27}
            })
        }

Ideally a driver should be able to support both legacy and modern BIOS
(i.e. both the above cases). But it seems to me that as per the
current code, the driver has to be aware of what kind of BIOS it is,
because it needs to deal with them differently:

* Use con_id=NULL if it is dealing with a legacy BIOS (i.e. no _DSD
properties in the ACPI).
* Use con_id=<actual string> if it is dealing with a modern BIOS (i.e.
which provides _DSD for the <string> property)

Questions:

1) Is the above a correct understanding of what the gpiolib expects?
So it seems to be that _CRS is not really a "fallback option" anymore
at the gpiolib end anymore (i.e. if a driver wants to support both the
cases (legacy and modern), then it would need to do the fallback
explicitly?)

2) If so, it seems that the the sdhci driver is broken for modern BIOS
as it uses con_id = NULL when calling mmc_gpiod_request_cd(). We can
possibly fix this by either relaxing.the rules to allow _CRS fallback
in gpiolib, or change the sdhci driver to try first using "cd" and
then NULL as the con_id. What do you think?

This is what I see on my system (running 4.19-rc3'ish):

sdhci-pci 0000:00:14.5: SDHCI controller found [8086:34f8] (rev 0)
sdhci-pci 0000:00:14.5: GPIO lookup for consumer (null)
sdhci-pci 0000:00:14.5: using ACPI for GPIO lookup
acpi device:03: GPIO: looking up gpios
acpi device:03: GPIO: looking up gpio
sdhci-pci 0000:00:14.5: using lookup tables for GPIO lookup
sdhci-pci 0000:00:14.5: No GPIO consumer (null) found
sdhci-pci 0000:00:14.5: failed to setup card detect gpio

This is how my ACPI looks for the device:

    Scope (\_SB.PCI0.SDXC)
    {
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            GpioInt (Edge, ActiveBoth, SharedAndWake, PullNone, 0x2710,
                "\\_SB.PCI0.GPIO", 0x00, ResourceConsumer, ,
                )
                {   // Pin list
                    0x0005
                }
        })
        Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
        {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device
Properties for _DSD */,
            Package (0x01)
            {
                Package (0x02)
                {
                    "cd-gpio",
                    Package (0x04)
                    {
                        \_SB.PCI0.SDXC,
                        Zero,
                        Zero,
                        One
                    }
                }
            }
        })
    }

Thanks,

Rajat
