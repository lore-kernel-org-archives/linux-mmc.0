From: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/6] mmc: Add OF bindings support for mmc host controller
 capabilities
Date: Mon, 7 Nov 2011 19:51:26 +0530
Message-ID: <CAJuYYwThsY0gwG4D3bNC-VnifggT6Y4f0s3FVHebAXdubTb4Zg@mail.gmail.com>
References: <1320266163-15292-1-git-send-email-thomas.abraham@linaro.org>
 <1320266163-15292-6-git-send-email-thomas.abraham@linaro.org>
 <20111104195717.GA3045@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20111104195717.GA3045-O5ziIzlqnXUVNXGz7ipsyg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 5 November 2011 01:27, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org> wrote:
> On Thu, Nov 03, 2011 at 02:06:02AM +0530, Thomas Abraham wrote:
>> Device nodes representing sd/mmc controllers in a device tree would incl=
ude
>> mmc host controller capabilities. Add support for parsing of mmc host
>> controller capabilities included in device nodes.
>>
>> Signed-off-by: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
>> =A0.../devicetree/bindings/mmc/linux-mmc-host.txt =A0 =A0 | =A0 13 +++++=
+++
>> =A0drivers/mmc/core/host.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0| =A0 31 ++++++++++++++++++++
>> =A0include/linux/mmc/host.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A01 +
>> =A03 files changed, 45 insertions(+), 0 deletions(-)
>> =A0create mode 100644 Documentation/devicetree/bindings/mmc/linux-mmc-ho=
st.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt b/=
Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
>> new file mode 100644
>> index 0000000..714b2b1
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/linux-mmc-host.txt
>> @@ -0,0 +1,13 @@
>> +* Linux MMC Host Controller Capabilities
>> +
>> +The following bindings can be used in a device node to specify any board
>> +specific mmc host controller capabilities.
>> +
>> +- linux,mmc_cap_4_bit_data - Host can do 4-bit transfers
>> +- linux,mmc_cap_mmc_highspeed - Host can do MMC high-speed timing
>> +- linux,mmc_cap_sd_highspeed - Host can do SD high-speed timing
>> +- linux,mmc_cap_needs_poll - Host needs polling for card detection
>> +- linux,mmc_cap_8_bit_data - Host can do 8-bit transfer
>> +- linux,mmc_cap_disable - Host can be disabled and re-enabled to save p=
ower
>> +- linux,mmc_cap_nonremovable - Host is connected to nonremovable media
>> +- linux,mmc_cap_erase - Host allows erase/trim commands
>
> linux-prefixed properties are a big red flag. The device tree should desc=
ribe
> the hardware, not what linux does with the hardware.

The vendor-prefixes documentation for device tree bindings includes
'linux' as an option. And I was trying to encode the linux specific
host controller capabilities using the above bindings.

>
> See previous comments about "support-8bit" for encoding exactly the same
> hardware capability in a linux-agnostic way. What the sdhci driver choose=
s to
> do with it is up to the driver, and in some cases it means it will set the
> capabilities flag.
>
> Same goes for the other properties. It should not go in as it is
> implemented in this patch, it needs to be fixed up.

Ok. I will remove all these linux specific bindings and replace with a
more generic ones. Bindings will be defined for all the linux defined
host capabilities. Non-linux platforms can add additional bindings as
required. A function to parse such properties from a controller device
node could actually be shared among all the mmc/sd host controller
drivers in linux. I will redo this patch and submit again.

Thanks Olof for your review and comments.

Regards,
Thomas.

>
>
> -Olof
>
