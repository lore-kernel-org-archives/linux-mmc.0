From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / LPSS: Work around wrong sdio _ADR 0 entry on some
 byt/cht devices
Date: Mon, 26 Dec 2016 23:13:30 +0100
Message-ID: <CAJZ5v0ikhNok7hE3yQkk82t4+5Ni2OpKSik+RBYGcCENso6psQ@mail.gmail.com>
References: <20161225102148.7706-1-hdegoede@redhat.com> <CAJZ5v0ibDwkA2Pc+nkYXS6Mq6CKT3jAnjrfCaEiCtZye5JD75A@mail.gmail.com>
 <087d2576-66f8-f3ea-e08b-95e5de9f701c@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <087d2576-66f8-f3ea-e08b-95e5de9f701c@redhat.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-mmc@vger.kernel.org, Stable <stable@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, Dec 26, 2016 at 11:48 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 26-12-16 00:25, Rafael J. Wysocki wrote:
>>
>> CC Mika and Andy.
>>
>> Plus I don't think -stable is going to take your patches directly.
>
>
> Not sure what you mean with this remark? According to:
>
> Documentation/stable_kernel_rules.txt
>
> Option 1
> ********
>
> To have the patch automatically included in the stable tree, add the tag
>
> .. code-block:: none
>
>      Cc: stable@vger.kernel.org
>
> in the sign-off area. Once the patch is merged it will be applied to
> the stable tree without anything else needing to be done by the author
> or subsystem maintainer.
>
> So yes, it won't get merged until it has been merged into Linus'
> tree. But AFAICT adding Cc: stable@vger.kernel.org is the right way
> to indicate that a patch is a bug-fix which should be applied to
> stable kernels once merged, which is my intention of adding the Cc.

Yes, you can add a CC: <stable@...> tag to indicate that the patch is
-stable material (in which case please also indicate which -stable
series you want it to go to).

No, you should not CC -stable on the patch submission.

The CC: <stable@...> tag is for the maintainer you're sending the
patch to rather than for -stable itself.

Thanks,
Rafael
